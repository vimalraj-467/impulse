# frozen_string_literal: true

require 'sidekiq'
require './app/platform/queue/rabbitmq'
require './app/platform/scheduler/sale/notification_worker'

module Platform
  module Scheduler
    module Sale
      class SaleWorker
        include Sidekiq::Job

        def perform(sale_id, scheduled_at)
          Platform::Scheduler::Sale::NotificationWorker.perform_at(Time.at(scheduled_at), sale_id)

          Platform::Queue::RabbitMQ.instance.publish('sale_queue', sale_id)
        end
      end
    end
  end
end
