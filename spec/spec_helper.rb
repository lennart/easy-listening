ENV["RACK_ENV"] ||= "test"
require ::File.join(::File.dirname(__FILE__),"..","config","boot")
require ::File.join(::File.dirname(__FILE__),"..","config","environment")

def recreate_db
  CouchRest.new(SiteConfig.couchdb_host).database!(SiteConfig.database_name).recreate!
end

def log(msg)
  puts msg if ENV["VERBOSE"]
end

Spec::Runner.configure do |config|
  config.mock_with :mocha
end

