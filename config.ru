# Bundler.setup :production
require './fyn'

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a")

require 'sinatra-cache-assets'

require 'rack/cache'

use Rack::Cache,
    :verbose => true,
    :metastore => "memcached://#{ENV['MEMCACHE_SERVERS']}",
    :entitystore => "memcached://#{ENV['MEMCACHE_SERVERS']}"

use Sinatra::CacheAssets
run FuckYeahNouns::Application
