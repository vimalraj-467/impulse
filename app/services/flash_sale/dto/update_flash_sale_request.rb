# frozen_string_literal: true

class UpdateFlashSaleRequest
  def initialize(data)
    @name = data['name']
    @description = data['description']
    @image = data['image']
    @inventory_quantity = data['inventory_quantity']
    @schedule_at = data['schedule_at']
    @schedule_till = data['schedule_till']
    @active = data['active']
  end

  def to_hash
    update_hash = {}

    update_hash[:name] = @name unless @name.nil?
    update_hash[:description] = @description unless @description.nil?
    update_hash[:image] = @image unless @image.nil?
    update_hash[:inventory_quantity] = @inventory_quantity unless @inventory_quantity.nil?
    update_hash[:schedule_at] = @schedule_at unless @schedule_at.nil?
    update_hash[:schedule_till] = @schedule_till unless @schedule_till.nil?
    update_hash[:active] = @active unless @active.nil?

    update_hash
  end
end
