# frozen_string_literal: true

require './app/platform/exceptions/base_exception'

class ImpulseController < Sinatra::Base
  def parse_request_body(dto_class)
    request_data = Platform::Utils::JsonUtils.parse(request.body.read)

    dto = dto_class.new(request_data)

    dto.validate!

    dto.to_hash
  end

  configure :production do
    set :show_exceptions, false
  end

  configure :development do
    set :show_exceptions, false
  end

  get '/health' do
    { status: 'ok' }.to_json
  end

  not_found do
    halt(404, 'Not Found')
  end

  error BaseException do |exception|
    puts "Error: =====> #{exception.to_hash.to_json}"

    halt(exception.status, { status: exception.status, message: exception.message }.to_json)
  end

  error do
    halt(500, { status: 500, message: "Something went wrong! \n#{env['sinatra.error'].message}" }.to_json)
  end
end
