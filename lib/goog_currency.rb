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
      #
      # Remove unicode character used as thousands separator by the Google API
      # Thanks to Nathan Long, http://stackoverflow.com/a/9420531
      #
      encoding_options = {
          :invalid           => :replace,  # Replace invalid byte sequences
          :undef             => :replace,  # Replace anything not defined in ASCII
          :replace           => '',        # Use a blank for those replacements
          :universal_newline => true       # Always break lines with \n
        }
        response_hash['rhs'].encode(Encoding.find('ASCII'), encoding_options).to_f
    else
      raise GoogCurrency::Exception, "An error occurred: #{response_hash['error']}"
    end
  end
  
  class Exception < StandardError; end
  class NoMethodException < StandardError; end
end
