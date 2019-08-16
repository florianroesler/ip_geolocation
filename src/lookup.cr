require "csv"
require "./location"
require "logger"

class Lookup

  DEFAULT_INPUT_PATH = "data/IP2LOCATION-LITE-DB3.CSV"
  @mapping = Hash(Range(Int64, Int64), UInt64).new
  @keys = Array(Range(Int64, Int64)).new
  @locations = Hash(UInt64, Location).new

  delegate :size, to: @mapping

  def find(value : Int64) : (Location | Nil)
    matched_range = @keys.bsearch do |range|
      value <= range.end
    end

    if matched_range && matched_range.includes?(value)
      digest = @mapping[matched_range]
      @locations[digest]
    end
  end

  def build_index(file_path = DEFAULT_INPUT_PATH)
    chunk_size = 100000

    File.open file_path do |io|
      indexed_records_count = 0
      io.each_line.each_slice(chunk_size) do |slice|
        chunk = slice.join("\n")
        parsed_csv = CSV.parse(chunk)

        parsed_csv.each do |row|
          location = Location.new(row[2], row[3], row[4], row[5])
          digest = location.hash
          @locations[digest] = location
          @mapping[row[0].to_i64..row[1].to_i64] = digest
        end

        indexed_records_count += slice.size
        puts "#{indexed_records_count} records indexed"
      end
    end

    @keys = @mapping.keys
  end
end
