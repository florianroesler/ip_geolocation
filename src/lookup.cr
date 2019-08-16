require "csv"
require "./location"
require "logger"

class Lookup

  DEFAULT_INPUT_PATH = "data/IP2LOCATION-LITE-DB3.CSV"
  @hash : Hash(Range(Int64, Int64), Location)
  @keys : Array(Range(Int64, Int64))
  delegate :size, to: @hash

  def initialize
    @hash = Hash(Range(Int64, Int64), Location).new
    @keys = Array(Range(Int64, Int64)).new
  end

  def find(value : Int64)
    matched_range = @keys.bsearch do |range|
      value <= range.end
    end

    if matched_range && matched_range.includes?(value)
      @hash[matched_range]
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
          @hash[row[0].to_i64..row[1].to_i64] = location
        end

        indexed_records_count += slice.size
        puts "#{indexed_records_count} records indexed"
      end
    end

    @keys = @hash.keys
  end
end
