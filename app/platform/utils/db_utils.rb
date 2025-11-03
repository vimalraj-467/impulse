# frozen_string_literal: true

module Platform
  module Utils
    module DbUtils
      def self.save(object)
        object.save!

        object.persisted? ? [nil, object] : [object.errors, nil]
      rescue StandardError => e
        [e.message, nil]
      end
    end
  end
end
