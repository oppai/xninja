ENV['TARGET'] ||= 'test'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'support'))

require 'rspec'

Dir['./lib/*.rb'].each do |f|
  require f
end

Dir['./support/**/*.rb'].each do |f|
  require f
end

RSpec.configure do |_config|
end
