require "benchmark"
require "csv"
require "../src/location"
require "../src/lookup"

lookup = Lookup.new

File.open "data/IP2LOCATION-LITE-DB3.CSV" do |io|
  chunk = io.each_line.first(10).join("\n")
  parsed_csv = CSV.parse(chunk)

  parsed_csv.each do |row|
    location = Location.new(row[2], row[3], row[4], row[5])
    lookup.push(row[0].to_i, row[1].to_i, location)
  end

  puts lookup.find(1).inspect
end
