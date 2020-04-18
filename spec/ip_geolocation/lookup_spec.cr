require "../spec_helper"

describe IPGeolocation::Lookup do
  describe "#build_index" do
    it "builds an index" do
      lookup = IPGeolocation::Lookup.new
      lookup.build_index("spec/fixtures/excerpt.zip")
      lookup.size.should eq(100)
    end
  end

  describe "#find" do
    it "returns a location for a fitting range" do
      lookup = IPGeolocation::Lookup.new
      lookup.build_index("spec/fixtures/excerpt.zip")

      found_location = lookup.find(0)
      found_location.should be_a(IPGeolocation::Location)
      found_location.not_nil!.city.should eq("-")

      found_location = lookup.find(16777216)
      found_location.should be_a(IPGeolocation::Location)
      found_location.not_nil!.city.should eq("Los Angeles")

      lookup.find(168230444).should eq(nil)

      found_location = lookup.find(16781311)
      found_location.should be_a(IPGeolocation::Location)
      found_location.not_nil!.city.should eq("Guangzhou")
    end
  end
end
