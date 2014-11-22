require 'sinatra'
require 'sinatra/activerecord'
require './app/models/application'

set :show_exceptions, :after_handler

error ActiveRecord::RecordNotFound do
  status 404
end

post '/deployments/:token' do |token|
  Application.find_by!(token: token).track_deployment!
  status 204
end
