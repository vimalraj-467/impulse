# frozen_string_literal: true

class FlashSaleResponse
  def self.from_entity(flash_sale)
    {
      id: flash_sale['_id'],
      name: flash_sale['name'],
      description: flash_sale['description'],
      image: flash_sale['image'],
      inventory_quantity: flash_sale['inventory_quantity'],
      schedule_at: flash_sale['schedule_at'],
      schedule_till: flash_sale['schedule_till'],
      active: flash_sale['active'],
      user_id: flash_sale['user_id']
    }
  end
end
