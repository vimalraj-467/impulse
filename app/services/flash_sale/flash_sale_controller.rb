# frozen_string_literal: true

require './app/services/flash_sale/flash_sale_service'
require './app/services/flash_sale/dto/create_flash_sale_request'
require './app/services/flash_sale/dto/flash_sale_response'

class FlashSaleController < ImpulseController
  include Services::FlashSale::FlashSaleService

  post '/' do
    flash_sale_dto = parse_request_body(Services::FlashSale::Dto::CreateFlashSaleRequest)

    flash_sale = create_flash_sale(flash_sale_dto)

    Platform::Utils::JsonUtils.send_response(201, FlashSaleResponse.from_entity(flash_sale))
  end
end
