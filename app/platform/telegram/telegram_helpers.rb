# frozen_string_literal: true

require 'singleton'
require 'telegram/bot'

module Platform
  module Telegram
    class TelegramHelpers
      include Singleton

      def initialize
        @bot = ::Telegram::Bot::Client.new(ENV.fetch('IMPLUZ_BOT_TOKEN'))
        @channel_id = ENV.fetch('IMPLUZ_CHANNEL_ID')
      end

      def send_message_to_channel(text)
        @bot.api.send_message(chat_id: @channel_id, text: text)
      end

      def send_photo_to_channel(image_url)
        @bot.api.send_photo(chat_id: @channel_id, photo: image_url)
      end
    end
  end
end
