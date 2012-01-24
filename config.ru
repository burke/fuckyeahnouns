# Bundler.setup :production
require './fyn'
require 'sinatra-cache-assets'
require 'rack/cache'
if ENV['MEMCACHE_SERVERS']
  use Rack::Cache,
      verbose:     true,
      metastore:   "memcached://#{ENV['MEMCACHE_SERVERS']}",
      entitystore: "memcached://#{ENV['MEMCACHE_SERVERS']}"
end
use Sinatra::CacheAssets
run FuckYeahNouns::Application
