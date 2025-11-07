# frozen_string_literal: true

require 'sinatra/base'
require 'dotenv'
require 'sidekiq/web'

require 'mongoid'

Dotenv.load('.env')

# Set environment
ENV['RACK_ENV'] ||= 'development'

# Load Mongoid with environment
Mongoid.load!('config/mongoid.yml', ENV['RACK_ENV'].to_sym)

use Rack::Session::Cookie, secret: ENV.fetch('SESSION_SECRET'), expire_after: 86_400

require './app/impulse_controller'

Dir.glob('./app/platform/**/*.rb').sort.each do |file|
  require file
end

Dir.glob('./app/services/**/*.rb').sort.each do |file|
  require file
end

map('/api/v1') { run ImpulseController }
map('/api/v1/flash-sales') { run FlashSaleController }
map('/api/v1/users') { run UserController }
map('/api/v1/orders') { run OrderController }
map('/sidekiq') { run Sidekiq::Web }
