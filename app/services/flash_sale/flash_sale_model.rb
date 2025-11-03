# frozen_string_literal: true

class FlashSale
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :image, type: String
  field :inventory_quantity, type: Integer
  field :schedule_at, type: Time
  field :schedule_till, type: Time
  field :active, type: Boolean
  field :user_id, type: BSON::ObjectId
end
