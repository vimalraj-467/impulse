# frozen_string_literal: true

require 'dotenv/load'
require 'bunny'
require 'mongoid'
require './app/services/flash_sale/flash_sale_model'
require './app/platform/exceptions/base_exception'
require './app/platform/exceptions/error_code'
require './app/platform/exceptions/NotFoundException'
require './app/services/flash_sale/flash_sale_service'
require './app/platform/search/elasticsearch_helper'

Dotenv.load('.env')

Mongoid.load!('config/mongoid.yml', ENV['RACK_ENV'].to_sym)

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel
queue = channel.queue('sale_queue', durable: true)

channel.prefetch(1)

begin
  queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, sale_id|
    flash_sale = Services::FlashSale::FlashSaleService.get(sale_id)

    doc_hash = flash_sale.as_document

    doc_hash.delete('_id')

    Platform::Search::ElasticSearchHelper.instance.index('subscribers', doc_hash)

    channel.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _e
  connection.close
end
