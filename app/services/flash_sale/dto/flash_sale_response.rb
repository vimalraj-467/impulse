# frozen_string_literal: true

class FlashSaleResponse
  def self.from_entity(flash_sale)
    {
      name: flash_sale.name,
      description: flash_sale.description
    }
  end
end
