# frozen_string_literal: true

class User
  include Mongoid::Document

  field :nickname, type: String
  field :external_id, type: String

  validates :external_id, uniqueness: true
end
