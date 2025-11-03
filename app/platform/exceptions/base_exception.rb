# frozen_string_literal: true

class BaseException < StandardError
  attr_reader :status, :error_code, :message, :cause

  def initialize(status, error_code, message, cause = nil)
    super(status)
    @status = status
    @error_code = error_code
    @message = message
    @cause = cause
  end

  def to_hash
    { status: @status, error_code: @error_code, message: @message, cause: @cause }
  end
end
