# frozen_string_literal: true

require 'dotenv/load'
require 'bunny'
require 'mongoid'
require './app/services/flash_sale/flash_sale_model'
require './app/platform/exceptions/base_exception'
require './app/platform/exceptions/error_code'
require './app/platform/exceptions/NotFoundException'
require './app/services/flash_sale/flash_sale_service'
require './app/platform/telegram/telegram_helpers'
require './app/platform/cache/redis_helper'

Dotenv.load('.env')

Mongoid.load!('config/mongoid.yml', ENV['RACK_ENV'].to_sym)

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel
queue = channel.queue('notification_queue', durable: true)

channel.prefetch(1)

begin
  queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, sale_id|
    flash_sale = Services::FlashSale::FlashSaleService.get(sale_id)

    Platform::Cache::RedisHelper.instance.set("sale:#{sale_id}", flash_sale['inventory_quantity'])

    text = "Hey everyone, sale for #{flash_sale['name']} is starting now ! \nClick this link to purchase https://example.com"

    Platform::Telegram::TelegramHelpers.instance.send_message_to_channel(text)

    Platform::Telegram::TelegramHelpers.instance.send_photo_to_channel(flash_sale['image'])

    channel.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _e
  connection.close
end
