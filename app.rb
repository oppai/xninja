require 'sinatra'
require './lib/xninja'
require 'json'

module XNinja 
  class App < Sinatra::Base
    set :public_folder, File.dirname(__FILE__) + '/public'

    def ninja
      return @ninja unless @ninja.nil?
      @ninja = XNinja::Client.new
    end

    before do
      @title = 'XNinja'
      @site_image = 'http://i.gyazo.com/7b5f0e024ef643aadda904c24d1c0eea.png'
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
