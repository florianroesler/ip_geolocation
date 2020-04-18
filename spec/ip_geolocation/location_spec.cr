require "../spec_helper"

describe IPGeolocation::Location do
  describe "#initialize" do
    it "creates a location with properties" do
      location = IPGeolocation::Location.new("US", "United States", "California", "Los Angeles")

      location.alpha_2.should eq("US")
      location.country.should eq("United States")
      location.state.should eq("California")
      location.city.should eq("Los Angeles")
    end
  end

  describe "#to_json" do
    it "creates a location with properties" do
      location = IPGeolocation::Location.new("US", "United States", "California", "Los Angeles")

      location.to_json.should eq("{\"alpha_2\":\"US\",\"country\":\"United States\",\"state\":\"California\",\"city\":\"Los Angeles\"}")
    end
  end

  describe "#hash" do
    it "returns same hash for equal objects" do
      location = IPGeolocation::Location.new("US", "United States", "California", "Los Angeles")
      same_location = IPGeolocation::Location.new("US", "United States", "California", "Los Angeles")

      location.hash.should eq(same_location.hash)
    end
  end
end
