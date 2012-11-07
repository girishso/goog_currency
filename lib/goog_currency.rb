require "goog_currency/version"
require 'rest_client'
require 'json'

module GoogCurrency
  def self.method_missing(meth, *args)
    puts "meee! meth=#{meth} args=#{args}"
    
    from, to = meth.to_s.split("_to_")
    
    response = RestClient.get("http://www.google.com/ig/calculator?hl=en&q=#{args.first}#{from.upcase}=?#{to.upcase}").body
    
    # response is not valid json
    response.gsub!(/(lhs|rhs|error|icc)/, '"\1"')
    response_hash = JSON.parse(response)

    if response_hash['error'].nil? or response_hash['error'] == ''
      response_hash['rhs'].to_f
    else
      raise GoogCurrency::Exception, "An error occurred: #{response_hash['error']}"
    end

    # super
  end
  
  class Exception < StandardError; end
end
