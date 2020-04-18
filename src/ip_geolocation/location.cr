require "json"

module IPGeolocation
  Pool = StringPool.new

  struct Location
    include JSON::Serializable

    property alpha_2 : String
    property country : String
    property state : String
    property city : String

    def initialize(alpha_2 : String, country : String, state : String, city : String)
      @alpha_2 = Pool.get(alpha_2)
      @country = Pool.get(country)
      @state = Pool.get(state)
      @city = Pool.get(city)
    end

    def crc32
      Digest::CRC32.checksum(hash.to_s)
    end
  end
end
