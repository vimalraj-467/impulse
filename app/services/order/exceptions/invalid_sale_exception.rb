# frozen_string_literal: true

class InvalidSaleException < BaseException
  def initialize(message, cause = nil)
    super(404, Platform::Exceptions::ErrorCode::INVALID_SALE, message, cause)
  end
end
