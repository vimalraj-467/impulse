# frozen_string_literal: true

module Services
  module FlashSale
    module Dto
      class FlashSaleResponse
        attr_accessor :name, :description

        def initialize(flash_sale)
          @name = flash_sale.name
          @description = flash_sale.description
        end

        def to_response
          { name => @name, description => @description }
        end
      end
    end
  end
end
