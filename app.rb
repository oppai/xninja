require 'sinatra'
module XOppai
  class App < Sinatra::Base
    get '/' do
      "Hello"
    end
  end
end
