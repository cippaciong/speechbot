# config.ru
require 'bundler'
Bundler.require

require_relative 'app'

use Rack::ContentType, "text/html"

run App
