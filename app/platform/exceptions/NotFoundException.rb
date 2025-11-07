# frozen_string_literal: true

class NotFoundException < BaseException
  def initialize
    super(404, Platform::Exceptions::ErrorCode::NOT_FOUND_ERROR, 'NOT FOUND', nil)
  end
end
