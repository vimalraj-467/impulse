# frozen_string_literal: true

require './app/services/user/user_service'
require './app/services/user/dto/create_user_request'
require './app/services/user/dto/user_response'

class UserController < ImpulseController
  include Services::User::UserService

  post '/' do
    user_dto = parse_request_body(CreateUserRequest)

    user = create_user(user_dto)

    Platform::Utils::JsonUtils.send_response(201, UserResponse.from_entity(user))
  end

  get '/:external_id' do
    user = get_user(params[:external_id])

    Platform::Utils::JsonUtils.send_response(200, UserResponse.from_entity(user))
  end
end
