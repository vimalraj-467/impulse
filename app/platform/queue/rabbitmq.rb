# frozen_string_literal: true

require 'bunny'
require 'singleton'

module Platform
  module Queue
    class RabbitMQ
      include Singleton

      def initialize
        connection = Bunny.new(automatically_recover: false)
        connection.start

        @exchange = connection.create_channel
      end

      def publish(queue_name, data)
        queue = @exchange.queue(queue_name, durable: true)

        queue.publish(data, persistent: true)
      end
    end
  end
end
