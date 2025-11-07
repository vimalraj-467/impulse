# frozen_string_literal: true

require './app/services/flash_sale/flash_sale_service'
require './app/services/flash_sale/dto/create_flash_sale_request'
require './app/services/flash_sale/dto/flash_sale_response'

class FlashSaleController < ImpulseController
  include Services::FlashSale::FlashSaleService

  post '/' do
    flash_sale_dto = parse_request_body(CreateFlashSaleRequest)

    flash_sale = create(flash_sale_dto)

    Platform::Utils::JsonUtils.send_response(201, flash_sale)
  end

  get '/upcoming' do
    flash_sales = get_upcoming

    Platform::Utils::JsonUtils.send_response(201, flash_sales)
  end

  get '/search' do
    Platform::Utils::JsonUtils.send_response(201, search(params[:query]))
  end

  get '/:id' do
    flash_sale = get(params[:id])

    Platform::Utils::JsonUtils.send_response(201, flash_sale)
  end

  delete '/:id' do
    delete(params[:id])
  end

  patch '/:id' do
    flash_sale_dto = parse_request_body(UpdateFlashSaleRequest)

    flash_sale = update(params[:id], flash_sale_dto)

    Platform::Utils::JsonUtils.send_response(201, flash_sale)
  end
end
