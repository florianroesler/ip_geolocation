require "../spec_helper"

describe IPGeolocation::IPAddress do
  describe "#initialize" do
    it "creates an ip address object" do
      IPGeolocation::IPAddress.new("1.1.1.1").address.should eq("1.1.1.1")
    end
  end

  describe "#to_u32" do
    it "converts the address to its integer representation" do
      IPGeolocation::IPAddress.new("0.0.0.0").to_u32.should eq(0)
      IPGeolocation::IPAddress.new("1.2.3.4").to_u32.should eq(16909060)
      IPGeolocation::IPAddress.new("10.0.2.15").to_u32.should eq(167772687)
    end
  end
end
