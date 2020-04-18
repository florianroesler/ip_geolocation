require "csv"
require "zip"

module IPGeolocation
  class Lookup
    DEFAULT_INPUT_PATH = "data/IP2LOCATION-LITE-DB3.CSV.ZIP"
    @mapping = Hash(Range(UInt32, UInt32), UInt32).new
    @keys = Array(Range(UInt32, UInt32)).new
    @locations = Hash(UInt32, Location).new

    delegate :size, to: @mapping

    def find(value : UInt32) : (Location | Nil)
      matched_range = @keys.bsearch do |range|
        value <= range.end
      end

      if matched_range && matched_range.includes?(value)
        digest = @mapping[matched_range]
        @locations[digest]
      end
    end

    def build_index(file_path = DEFAULT_INPUT_PATH)
      Log.info { "Building Geolocation Index" }

      Zip::File.open(file_path) do |zip_file|
        zip_file
          .entries
          .find { |entry| entry.filename.downcase.ends_with?(".csv") }
          .not_nil!
          .open { |io| process_index_file(io) }
      end

      Log.info { "Finished building Geolocation Index" }
    end

    private def process_index_file(io)
      chunk_size = 100000

      indexed_records_count = 0
      io.each_line.each_slice(chunk_size) do |slice|
        chunk = slice.join("\n")
        parsed_csv = CSV.parse(chunk)

        parsed_csv.each do |row|
          location = Location.new(row[2], row[3], row[4], row[5])
          digest = location.crc32
          @locations[digest] = location
          @mapping[row[0].to_u32..row[1].to_u32] = digest
        end

        indexed_records_count += slice.size
        Log.debug { "#{indexed_records_count} records indexed" }
      end
      @keys = @mapping.keys
    end
  end
end
