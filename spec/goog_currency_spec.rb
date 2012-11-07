require 'json'

describe "GoogCurrency" do
  describe "convert valid currencies" do
    it "converts USD to INR" do
      
      Currency.usd_to_inr(20)
    end
  end
end