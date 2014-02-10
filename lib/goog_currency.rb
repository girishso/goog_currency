require "goog_currency/version"
require 'open-uri'

module GoogCurrency
  def self.method_missing(meth, *args)
    from, to = meth.to_s.split("_to_")

    if from.nil? or to.nil? or from == "" or to == ""
      raise NoMethodException, "GoogCurrency accepts methods in 'usd_to_inr' or 'gbp_to_usd' format"
    end

    response = open("http://www.google.com/finance/converter?a=#{args.first}&from=#{from.upcase}&to=#{to.upcase}").read
    handle_response(response)
  end

  def self.respond_to?(meth)
    from, to = meth.to_s.split("_to_")

    if from.nil? or from == "" or to.nil? or to == ""
      super
    else
      true
    end
  end

  def self.handle_response(response)
    value = response.scan(/<span class=bld>([^.]+(?:\.(?:\d+))?)/)
    raise "An error occurred: Currency not found" if value.empty?
    value[0][0].to_f
  end

  def self.convert_response(response)
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
    JSON.parse(response)
  end

  private_class_method :convert_response
  class Exception < StandardError; end
  class NoMethodException < StandardError; end
end
