require 'sinatra'
require './lib/xninja'

module XNinja 
  class App < Sinatra::Base
    before do
      @title = 'XNinja'
    end

    get '/' do
      ninja = XNinja::Client.new
      @top = ninja.top
      erb :index
    end
  end
end
