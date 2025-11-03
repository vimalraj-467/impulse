# frozen_string_literal: true

require './app/platform/exceptions/validation_exception'

module Services
  module FlashSale
    module Dto
      class CreateFlashSaleRequest
        attr_reader :name, :description

        def initialize(data)
          @name = data['name']
          @description = data['description']
        end

        def validate!
          errors = []

          errors << 'name is required' if @name.nil? || @name.to_s.strip.empty?
          errors << 'description is required' if @description.nil? || @description.to_s.strip.empty?

          raise ValidationException, errors.join(', ') unless errors.empty?
        end

        def to_hash
          {
            'name' => @name,
            'description' => @description
          }
        end
      end
    end
  end
end
