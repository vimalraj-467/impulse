# frozen_string_literal: true

module Platform
  module Utils
    class JsonUtils
      def self.parse(json)
        JSON.parse(json)
      end

      def self.send_response(status, object)
        { status: status, data: object }.to_json
      end
    end
  end
end
