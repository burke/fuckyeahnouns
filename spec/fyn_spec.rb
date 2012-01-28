require './fyn'
require 'rack/test'

describe FuckYeahNouns::Application do
  include Rack::Test::Methods

  def should_be_cached
    last_response.headers['Cache-Control'].should =~ /public, must-revalidate, max-age=\d+/
  end

  def app
    @app ||= subject
  end

  def test_image
    File.new('spec/support/test_image.jpg')
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

  describe 'get noun image' do
    before(:each) do
      Actions::Image.stub(:annotate) { test_image }
      Actions::Image.stub(:fetch)    { test_image }
      get '/images/sleepy'
    end

    it 'loads' do
      last_response.should be_ok
    end

    it 'is content-type of jpg' do
      last_response.headers['content-type'].should == 'image/jpeg'
    end

    it 'is cached' do
      should_be_cached
    end
  end

  describe 'get noun' do
    before(:each) do
      Actions::Image.stub(:annotate) { test_image }
      Actions::Image.stub(:fetch)    { test_image }
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
      should_be_cached
    end
  end
end
