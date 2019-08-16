require "csv"
require "./location"
class Lookup

  DEFAULT_INPUT_PATH = "data/IP2LOCATION-LITE-DB3.CSV"
  @hash : Hash(Range(Int64, Int64), Location)

  delegate :size, to: @hash

  def initialize
    @hash = Hash(Range(Int64, Int64), Location).new
  end

  def find(value : Int64)
    result = @hash.keys.bsearch do |range, location|

      puts "#{range.inspect} #{value}"
      range.includes?(value)
    end

    result.last if result
  end

  def build_index(file_path = DEFAULT_INPUT_PATH)
    max_lines = 2912820.to_f
    chunk_size = 100000

    File.open file_path do |io|
      index = 0
      io.each_line.each_slice(chunk_size) do |slice|
        chunk = slice.join("\n")
        parsed_csv = CSV.parse(chunk)

        parsed_csv.each do |row|
          location = Location.new(row[2], row[3], row[4], row[5])
          @hash[row[0].to_i64..row[1].to_i64] = location
        end

        index += 1
        progress = Math.min(chunk_size * index, max_lines)
        puts "#{(progress / max_lines * 100).round(1)}%"
      end
    end

  end
end
