# frozen_string_literal: true

require './app/platform/exceptions/validation_exception'

class CreateFlashSaleRequest
  def initialize(data)
    @name = data['name']
    @description = data['description']
    @image = data['image']
    @inventory_quantity = data['inventory_quantity']
    @schedule_at = data['schedule_at']
    @schedule_till = data['schedule_till']
    @active = data['active']
    @user_id = data['user_id']
  end

  def validate!
    errors = []

    errors << 'name is required' if @name.blank?
    errors << 'description is required' if @description.blank?
    errors << 'image is required' if @image.blank?
    errors << 'inventory_quantity is required' if @inventory_quantity.nil? || @inventory_quantity.negative?
    errors << 'schedule_at is required' unless @schedule_at.present? && @schedule_at > Time.now.to_i
    errors << 'schedule_till is required' unless @schedule_till.present? && @schedule_at < @schedule_till
    errors << 'active is required' if @active.blank?
    errors << 'user_id is required' if @user_id.blank?


    raise ValidationException, errors.join(', ') unless errors.empty?
  end

  def to_hash
    {
      'name' => @name,
      'description' => @description,
      'image' => @image,
      'inventory_quantity' => @inventory_quantity,
      'schedule_at' => @schedule_at,
      'schedule_till' => @schedule_till,
      'active' => @active,
      'user_id' => @user_id
    }
  end
end
