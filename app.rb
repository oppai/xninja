require 'sinatra'
require './lib/xninja'

module XNinja 
  class App < Sinatra::Base
    @title = 'XNinja'

    get '/' do
      ninja = XNinja::Client.new
      @top = ninja.top
      erb :index
    end
  end
end
