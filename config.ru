FileUtils.mkdir_p 'log' unless ::File.exists?('log')
log = ::File.new("log/sinatra.log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)

require ::File.join(::File.dirname(__FILE__), *%w{config boot})
require ::File.join(::File.dirname(__FILE__), *%w{config environment})
require ::File.dirname(__FILE__) + "/main.rb"

set :app_file, ::File.expand_path(::File.dirname(__FILE__) + '/main.rb')
set :public,   ::File.expand_path(::File.dirname(__FILE__) + '/public')
set :views,    ::File.expand_path(::File.dirname(__FILE__) + '/views')

disable :run, :reload

run ModularApplication
# vim:filetype=ruby
