# frozen_string_literal: true

class CreateOrderRequest
  def initialize(data)
    @user_id = data['user_id']
    @sale_id = data['sale_id']
  end

  def validate!
    errors = []

    errors << 'User id is required' if @user_id.nil?
    errors << 'sale_id is required' if @sale_id.nil?

    raise ValidationException, errors unless errors.empty?
  end

  def to_hash
    {
      user_id: @user_id,
      sale_id: @sale_id
    }
  end
end
