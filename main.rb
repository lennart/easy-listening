require File.join(File.dirname(__FILE__),*%w{config boot})

class ModularApplication < Sinatra::Base
  helpers Sinatra::UrlForHelper
  register Sinatra::StaticAssets

  enable :xhtml
  enable :sessions

  error do
    e = request.env['sinatra.error']
    puts e.to_s
    puts e.backtrace.join("\n")
    "Application error"
  end

  helpers do
  end

  get '/?' do
    "Hello World"
  end
end
