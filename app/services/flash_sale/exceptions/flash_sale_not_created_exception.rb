# frozen_string_literal: true

class FlashSaleNotCreatedException < BaseException
  def initialize(message, cause)
    super(500, Platform::Exceptions::ErrorCode::FLASH_SALE_NOT_CREATED, message, cause)
  end
end
