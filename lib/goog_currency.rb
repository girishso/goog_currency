require "goog_currency/version"
require 'rest_client'
require 'json'

module GoogCurrency
  def self.usd_to_inr(amount)
    response = RestClient.get("http://www.google.com/ig/calculator?hl=en&q=#{amount}USD=?INR").body
    
    # response is not valid json
    response.gsub!(/(lhs|rhs|error|icc)/, '"\1"')
    response_hash = JSON.parse(response)
    response_hash['rhs'].to_f
  end
end
