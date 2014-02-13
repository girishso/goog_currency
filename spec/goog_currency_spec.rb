$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require File.expand_path(File.dirname(__FILE__) + '/response_helper')
require 'fakeweb'
require 'goog_currency'

valid_response =<<-VALID
{lhs: "1 U.S. dollar",rhs: "62.2600 Indian rupees",error: "",icc: true}
VALID

valid100_response =<<-VALID_100
{lhs: "100 U.S. dollar",rhs: "5\u0080483.6587 Indian rupees",error: "",icc: true}
VALID_100
 
invalid_response =<<-INVALID
{lhs: "",rhs: "",error: "4",icc: false}
INVALID

describe "GoogCurrency" do
  describe "valid currencies" do
    it "converts USD to INR" do
      FakeWeb.register_uri(:get,
                           "http://www.google.com/finance/converter?a=1&from=USD&to=INR",
                           :status => "200",
                           :body => stub_usd_to_inr_response(1, 62.2600))
      usd = GoogCurrency.usd_to_inr(1)
      usd.should == 62.2600
    end

    it  "ignores thousands separator correctly" do
      FakeWeb.register_uri(:get,
                           "http://www.google.com/finance/converter?a=100&from=USD&to=INR",
                           :status => "200",
                           :body => stub_usd_to_inr_response(100, 6223))
      usd = GoogCurrency.usd_to_inr(100)
      usd.should == 6223
    end

    it "should work with currency that input as float" do
      FakeWeb.register_uri(:get,
                           "http://www.google.com/finance/converter?a=10.52&from=USD&to=INR",
                           :status => "200",
                           :body => stub_usd_to_inr_response(10.52, 654.6596))
      usd = GoogCurrency.usd_to_inr(10.52)
      usd.should == 654.6596
    end

    it "should work with currency that input as float and returns float" do
      FakeWeb.register_uri(:get,
                           "http://www.google.com/finance/converter?a=80.94&from=USD&to=INR",
                           :status => "200",
                           :body => stub_usd_to_inr_response(80.94, 5036.8962))
      usd = GoogCurrency.usd_to_inr(80.94)
      usd.should == 5036.8962
    end

    it "should return same amount when same currency code for from and to" do
      FakeWeb.register_uri(:get,
                           "http://www.google.com/finance/converter?a=1&from=USD&to=USD",
                           :status => "200",
                           :body => stub_usd_to_inr_response(1, 1))
      usd = GoogCurrency.usd_to_usd(1)
      usd.should == 1
    end
  end

  describe "invalid currencies" do
    it "throws exception for USD to INX" do
      FakeWeb.register_uri(:get,
                           "http://www.google.com/finance/converter?a==1USD=?INX",
                           :status => "200",
                           :body => stub_error_response)
      expect { GoogCurrency.usd_to_inx(1) }.to raise_error(GoogCurrency::Exception)
    end
  end
  
  describe "invalid method" do
    it "throws exception for invalid method" do
      expect { GoogCurrency.usd_2_inr(1) }.to raise_error(GoogCurrency::NoMethodException)
    end
  end

end
