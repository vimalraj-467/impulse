# frozen_string_literal: true

require './app/services/order/order_service'
class OrderController < ImpulseController
  include Services::Order

  post '/' do
    order_dto = parse_request_body(CreateOrderRequest)

    created_order = create(order_dto)

    Platform::Utils::JsonUtils.send_response(201, OrderResponse.from_entity(created_order))
  end
end
