# frozen_string_literal: true

class CreateUserException < BaseException
  def initialize(message, cause = nil)
    super(500, Platform::Exceptions::ErrorCode::USER_NOT_CREATED, message, cause)
  end
end
