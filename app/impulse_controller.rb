# frozen_string_literal: true

require './app/platform/exceptions/base_exception'

class ImpulseController < Sinatra::Base
  configure :production do
    set :show_exceptions, false
  end

  configure :development do
    set :show_exceptions, true
  end

  get '/health' do
    { status: 'ok' }.to_json
  end

  not_found do
    halt(404, 'Not Found')
  end

  error BaseException do |exception|
    puts "Error: =====> #{exception.to_hash.to_json}"

    halt(exception.status, exception.message)
  end

  error do
    halt(500, "Something went wrong! \n#{env['sinatra.error'].message}")
  end
end
