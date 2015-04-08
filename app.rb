require 'sinatra'
require './lib/xninja'

module XNinja 
  class App < Sinatra::Base
    get '/' do
      ninja = XNinja::Client.new
      ninja.top.to_s
    end
  end
end
