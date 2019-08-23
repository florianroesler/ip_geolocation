require "benchmark"
require "../src/ip_address"
require "../src/lookup"

lookup = Lookup.new
lookup.build_index

address = IPAddress.new("233.233.233.233")
address_as_int = address.to_u32.not_nil!

Benchmark.ips do |bm|
  bm.report("lookup") { lookup.find(address_as_int) }
end
