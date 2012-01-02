# Bundler.setup :production
require './fyn'

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a")

require 'sinatra-cache-assets'
use Sinatra::CacheAssets
run FuckYeahNouns::Application
