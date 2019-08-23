require "benchmark"
require "crc32"
require "../src/location"

result = Benchmark.memory do
  locations = Array(Location).new
  10000.times do
    locations << Location.new("US", "United States", "California", "Los Angeles")
  end
end

puts result

result = Benchmark.memory do
  locations = Hash(UInt32, Location).new
  10.times do |i|
    1000.times do
      l = Location.new("US#{i}", "United States", "California", "Los Angeles")
      locations[l.hash.to_u32] = l
    end
  end
end

puts result
