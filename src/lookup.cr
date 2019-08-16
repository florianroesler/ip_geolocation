require "csv"
require "./location"
class Lookup
  @hash : Hash(Range(Int64, Int64), Location)

  def initialize
    @hash = Hash(Range(Int64, Int64), Location).new
  end

  def find(value : Int64)
    result = @hash.find do |range, location|
      puts "#{range.inspect} #{value}"
      range.includes?(value)
    end

    if result
      result.last
    end
  end

  def build_index
    max_lines = 2912820.to_f
    chunk_size = 100000

    File.open "data/IP2LOCATION-LITE-DB3.CSV" do |io|
      index = 0
      io.each_line.each_slice(chunk_size) do |slice|
        chunk = slice.join("\n")
        parsed_csv = CSV.parse(chunk)

        parsed_csv.each do |row|
          location = Location.new(row[2], row[3], row[4], row[5])
          self.push(row[0].to_i64, row[1].to_i64, location)
        end

        index += 1
        progress = Math.min(chunk_size * index, max_lines)
        puts "#{(progress / max_lines * 100).round(1)}%"
        break
      end
    end

  end
end
