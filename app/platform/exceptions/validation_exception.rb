# frozen_string_literal: true

class ValidationException < BaseException
  def initialize(errors)
    super(400, Platform::Exceptions::ErrorCode::VALIDATION_FAILED, 'Bad Request', errors)
  end
end
