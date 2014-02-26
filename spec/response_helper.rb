$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'

require 'goog_currency'

RSpec.configure do |config|
  
end

def stub_usd_to_inr_response(input, output)
  File.open(File.expand_path(File.dirname(__FILE__) + '/helper/response_usd_to_inr.html'), 'r') do |f|
    body = f.read
    body.gsub!("<placeholder_in>", "#{input}")
    body.gsub!("<placeholder_out>", "#{output}")
    return body
  end
end

def stub_error_response
  File.open(File.expand_path(File.dirname(__FILE__) + '/helper/response_error.html'), 'r') do |f|
    body = f.read
  end
end