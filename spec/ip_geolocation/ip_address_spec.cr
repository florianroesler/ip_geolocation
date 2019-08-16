require "../spec_helper"

describe IPAddress do
  describe "#initialize" do
    it "creates an ip address object" do
      IPAddress.new("1.1.1.1").address.should eq("1.1.1.1")
    end
  end

  describe "#to_i64" do
    it "converts the address to its integer representation" do
      IPAddress.new("0.0.0.0").to_i64.should eq(0)
      IPAddress.new("1.2.3.4").to_i64.should eq(16909060)
      IPAddress.new("10.0.2.15").to_i64.should eq(167772687)
    end
  end
end
