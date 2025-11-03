# frozen_string_literal: true

require './app/services/flash_sale/flash_sale_service'
require './app/services/flash_sale/dto/create_flash_sale_request'
require './app/services/flash_sale/dto/flash_sale_response'

class FlashSaleController < ImpulseController
  include Services::FlashSale::FlashSaleService

  post '/' do
    request_data = Platform::Utils::JsonUtils.parse(request.body.read)

    flash_sale_dto = Services::FlashSale::Dto::CreateFlashSaleRequest.new(request_data)

    flash_sale_dto.validate!

    flash_sale = create_flash_sale(flash_sale_dto.to_hash)

    Platform::Utils::JsonUtils.send_response(200, FlashSaleResponse.from_entity(flash_sale))
  end
end
