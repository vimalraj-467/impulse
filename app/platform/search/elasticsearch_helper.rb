# frozen_string_literal: true

require 'elasticsearch'
require 'singleton'

module Platform
  module Search
    class ElasticSearchHelper
      include Singleton

      def initialize
        @client = Elasticsearch::Client.new(
          cloud_id: ENV.fetch('ELASTICSEARCH_CLOUD_ID'),
          api_key: ENV.fetch('ELASTICSEARCH_API_KEY')
        )
      end

      def index(index_name, data)
        response = @client.index(index: index_name, body: data)
        response['_id']
      end

      def search(index_name, query)
        @client.search(index: index_name, body: query)
      end
    end
  end
end
