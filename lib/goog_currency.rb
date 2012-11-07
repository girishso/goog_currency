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
    response_hash['rhs'].to_f

    # super
  end
end
