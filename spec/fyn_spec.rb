require './fyn'
require 'rack/test'
describe FuckYeahNouns::Application do
  include Rack::Test::Methods

  def app
    @app ||= subject
  end

  describe 'front page' do
    before(:each) do
      get '/'
    end

    it 'loads' do
      last_response.should be_ok
    end

    it 'contains the slogan' do
      last_response.body.should =~ /fuck yeah/i
    end

    it 'contains a form' do
      last_response.body.should =~/<form/i
    end
  end

  describe 'get noun' do

    before(:each) do
      get '/sleepy'
    end

    it 'loads' do
      last_response.should be_ok
    end

    it 'contains the noun' do
      last_response.body.should =~ /sleepy/
    end

    it 'contains an image' do
      last_response.body.should =~/<img/
    end

    it 'contains another form' do
      last_response.body.should =~/<form/i
    end

    it 'caches pages' do
      last_response.headers['Cache-Control'].should =~ /public; max-age=\d+/
    end
  end
end
