# frozen_string_literal: true

class FlashSale
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
end
