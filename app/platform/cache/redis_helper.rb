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

      def get_and_decrement(key)
        lua_script = <<~LUA
          local key = KEYS[1]
          local current = redis.call('GET', key)

          if not current then
            return {0, -1}#{'  '}
          end

          current = tonumber(current)

          if current <= 0 then
            return {0, -2}#{' '}
          end

          local new_value = redis.call('DECR', key)
          return {1, new_value}
        LUA

        @redis.eval(lua_script, keys: [key])
      end
    end
  end
end
