require 'rubygems'
require 'bundler'

root_dir = File.dirname(__FILE__)

require 'open-uri'
require 'json'
require 'cgi'
require 'RMagick'
require 'sinatra/base'
require 'timeout'
require 'newrelic_rpm'
require 'rest_client'
