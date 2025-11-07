# frozen_string_literal: true

require 'sidekiq'
require './app/platform/queue/rabbitmq'

module Platform
  module Scheduler
    module Sale
      class NotificationWorker
        include Sidekiq::Job

        def perform(sale_id)
          Platform::Queue::RabbitMQ.instance.publish('notification_queue', sale_id)
        end
      end
    end
  end
end
