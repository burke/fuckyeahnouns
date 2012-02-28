require './boot'
ENV['APP_ROOT'] ||= File.dirname(__FILE__)

require './actions/shirt'
require './actions/image'
require './actions/noun'
require './sources/bing'

module FuckYeahNouns
  class Application < Sinatra::Base
    configure :production do
      require 'newrelic_rpm'
    end

    set :public_folder, File.dirname(__FILE__) + '/public'

    before do
      cache_control :public, :must_revalidate, max_age: 36000
    end

    get '/' do
      erb :home
    end

    def noun
      @noun ||= Actions::Noun.create(params[:noun].freeze)
    end

    get '/shirt/:noun' do
      redirect noun.shirt.url
    end

    get '/images/:noun' do
      send_file noun.image.file, type: :jpg, disposition: :inline
    end

    get '/:noun' do
      noun
      erb :noun
    end
  end
end
