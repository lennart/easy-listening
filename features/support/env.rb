ENV["RACK_ENV"] = "integration"
require File.join(File.dirname(__FILE__), *%w{.. .. config boot})
require sinatra %w{config environment}
app_file = sinatra "main.rb"
require app_file
Sinatra::Application.app_file = app_file

require 'spec/expectations'
require 'rack/test'
require 'capybara/cucumber'

Capybara.app = ModularApplication

class MyWorld
  include Rack::Test::Methods

  def app
    ModularApplication
  end
end

World{MyWorld.new}
