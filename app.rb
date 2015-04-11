require 'sinatra'
require './lib/xninja'
require 'json'

module XNinja 
  class App < Sinatra::Base
    def ninja
      return @ninja unless @ninja.nil?
      @ninja = XNinja::Client.new
    end

    before do
      @title = 'XNinja'
    end

    get '/' do
      @top = ninja.top
      erb :index
    end

    get '/video/:id' do
      video = ninja.detail(params['id'])
      redirect video[:high]
    end

    get '/api/new/:id' do
      ninja.top(params['id']).to_json
    end
  end
end
