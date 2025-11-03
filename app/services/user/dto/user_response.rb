# frozen_string_literal: true

class UserResponse
  def self.from_entity(data)
    {
      nickname: data['nickname'],
      external_id: data['external_id']
    }
  end
end
