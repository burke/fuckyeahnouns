require './fyn'
require 'rack/test'
describe FuckYeahNouns::Application do
  include Rack::Test::Methods

  def app
    @app ||= subject
  end

  it 'front page loads' do
    get '/'
    last_response.should be_ok
    last_response.body.should =~ /fuck yeah/i
    last_response.body.should =~/<form/i
  end

  it 'gets noun' do
    get '/test'
    last_response.should be_ok
    last_response.body.should =~ /test/
    last_response.body.should =~/<img/
    last_response.body.should =~/<form/i
  end
end
