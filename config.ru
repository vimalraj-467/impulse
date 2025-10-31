require 'sinatra/base'
require 'dotenv'
require 'mongoid'

Dotenv.load('.env')

Mongoid.load!('config/mongoid.yml')

require './app/impulse_controller'

Dir.glob('./app/services/**/*.rb').each do |file|
  require file
end

map('/') { run ImpulseController }
map('/flash-sales') { run FlashSaleController }