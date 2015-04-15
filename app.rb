require 'sinatra'
require './lib/xninja'
require 'json'

module XNinja 
  class App < Sinatra::Base
    set :public_folder, File.dirname(__FILE__) + '/public'

    if ENV['RACK_ENV'] == "production" then
      disable :show_exceptions
    end

    def ninja
      return @ninja unless @ninja.nil?
      @ninja = XNinja::Client.new
    end

    before do
      @title = 'XNinja'
      @site_image = 'http://i.gyazo.com/7b5f0e024ef643aadda904c24d1c0eea.png'
    end

    get '/' do
      @list = ninja.top
      erb :index
    end

    get '/search/:word' do
      @list = ninja.search(params['word'])
      erb :search
    end

    get '/video/:id' do
      video = ninja.detail(params['id'])
      redirect video[:high]
    end

    get '/api/new/:id' do
      ninja.top(params['id']).to_json
    end

    get '/api/search/:word/:id' do
      ninja.search(params['word'],params['id']).to_json
    end

  end
end
