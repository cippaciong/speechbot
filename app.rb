#! /usr/bin/env ruby

lib = File.expand_path('../lib/', __FILE__)  
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rack'
require 'rack/server'
require 'json'
require 'logger'
require 'speechbot'


class App
  @bot = SpeechBot.new
  def self.call(env)
    request = Rack::Request.new env

    if request.post?
      body = String.new
      request.body.each do |data|
        body += data
      end
      @bot.update(body)
      [200, {}, []]
    end
  end
end
