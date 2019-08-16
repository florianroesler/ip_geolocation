class Location
  include JSON::Serializable

  property alpha_2 : String
  property country : String
  property state : String
  property city : String

  def initialize(@alpha_2 : String, @country : String, @state : String, @city : String)
  end
end
