require "../spec_helper"

describe Location do
  describe "#initialize" do
    it "creates a location with properties" do
      location = Location.new("US", "United States", "California", "Los Angeles")

      location.alpha_2.should eq("US")
      location.country.should eq("United States")
      location.state.should eq("California")
      location.city.should eq("Los Angeles")
    end
  end

  describe "#to_json" do
    it "creates a location with properties" do
      location = Location.new("US", "United States", "California", "Los Angeles")

      location.to_json.should eq("{\"alpha_2\":\"US\",\"country\":\"United States\",\"state\":\"California\",\"city\":\"Los Angeles\"}")
    end
  end
end
