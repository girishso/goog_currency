require "goog_currency/version"
require 'rest_client'
require 'json'

module GoogCurrency
  MILLION = 1_000_000
  def self.method_missing(meth, *args)
    from, to = meth.to_s.split("_to_")

    if from.nil? or to.nil? or from == "" or to == ""
      raise NoMethodException, "GoogCurrency accepts methods in 'usd_to_inr' or 'gbp_to_usd' format"
    end

    response = RestClient.get("http://www.google.com/ig/calculator?hl=en&q=#{args.first}#{from.upcase}=?#{to.upcase}").body

    # response is not valid json
    # Remove unicode character used as thousands separator by the Google API
    encoding_options = {
      :invalid           => :replace,  # Replace invalid byte sequences
      :undef             => :replace,  # Replace anything not defined in ASCII
      :replace           => ''        # Use a blank for those replacements
      #:universal_newline => true       # Always break lines with \n
    }
    response = response.encode(Encoding.find('ASCII'), encoding_options)
    response.gsub!(/(lhs|rhs|error|icc)/, '"\1"')
    response_hash = JSON.parse(response)

    if response_hash['error'].nil? or response_hash['error'] == ''
      case response_hash['rhs']
      when /million/
        response_hash['rhs'].to_f * MILLION
      when /billion/
        response_hash['rhs'].to_f * MILLION * 1_000
      when /trillion/
        response_hash['rhs'].to_f * MILLION * MILLION
      else
        response_hash['rhs'].to_f
      end
    else
      raise Exception, "An error occurred: #{response_hash['error']}"
    end
  end

  def self.respond_to?(meth)
    from, to = meth.to_s.split("_to_")

    if from.nil? or from == "" or to.nil? or to == ""
      super
    else
      true
    end
  end

  class Exception < StandardError; end
  class NoMethodException < StandardError; end
end
