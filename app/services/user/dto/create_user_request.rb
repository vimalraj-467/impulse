# frozen_string_literal: true

class CreateUserRequest
  def initialize(data)
    @nickname = data['nickname']
    @external_id = data['external_id']
  end

  def validate!
    errors = []
    errors.push('Nickname is missing') if @nickname.nil? || @nickname.empty?
    errors.push('external id is missing') if  @external_id.nil? || @external_id.empty?
    raise ValidationException, errors.join(', ') if errors.length.positive?
  end

  def to_hash
    {
      nickname: @nickname,
      external_id: @external_id
    }
  end
end
