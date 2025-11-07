# frozen_string_literal: true

class OrderResponse
  def self.from_entity(order)
    {
      id: order['_id']
    }
  end
end
