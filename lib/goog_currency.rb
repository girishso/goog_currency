require "goog_currency/version"
require 'rest_client'
require 'json'

module GoogCurrency
  def self.method_missing(meth, *args)
    from, to = meth.to_s.split("_to_")
    
    if from.nil? or to.nil?
      raise GoogCurrency::NoMethodException, "GoogCurrency accepts methods in 'usd_to_inr' or 'gbp_to_usd' format"
    end
    
    response = RestClient.get("http://www.google.com/ig/calculator?hl=en&q=#{args.first}#{from.upcase}=?#{to.upcase}").body
    
    # response is not valid json
    response.gsub!(/(lhs|rhs|error|icc)/, '"\1"')
    response_hash = JSON.parse(response)

    if response_hash['error'].nil? or response_hash['error'] == ''
      response_hash['rhs'].to_f
    else
      raise GoogCurrency::Exception, "An error occurred: #{response_hash['error']}"
    end
  end
  
  class Exception < StandardError; end
  class NoMethodException < StandardError; end
end
