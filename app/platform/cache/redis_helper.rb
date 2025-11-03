# frozen_string_literal: true

require 'redis'
require 'singleton'

module Platform
  module Cache
    class RedisHelper
      include Singleton

      def initialize
        @redis = Redis.new(host: ENV.fetch('REDIS_HOSTNAME', nil), port: ENV.fetch('REDISPORT', nil),
                           db: ENV.fetch('REDIS_DB', nil))
      end

      def set(key, value)
        @redis.set(key, value)
      end

      def get(key)
        @redis.get(key)
      end
    end
  end
end
