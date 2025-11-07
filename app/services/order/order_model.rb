# frozen_string_literal: true

class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: BSON::ObjectId
  field :sale_id, type: BSON::ObjectId
  field :status, type: String
end
