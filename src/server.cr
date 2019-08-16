require "kemal"
require "http/client"
require "logger"
require "../src/lookup"

Log = Logger.new(STDOUT)
Log.level = Logger::DEBUG

lookup = Lookup.new
lookup.build_index#("data/excerpt.csv")

before_all do |env|
	env.response.content_type = "application/json"
end

get "/" do
	{ status: "Believe me I am still alive!" }.to_json
end

IPV4_REGEX = /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/

get "/v1/locate" do |env|
	query = env.params.query.fetch("q", "").strip

	if IPV4_REGEX.match(query)
		ip_as_int = query.split(".").reduce(Int64.new(0)) { |total, value| (total << 8 ) + value.to_i }
		lookup.find(ip_as_int.to_i64).to_json
	else
		int_value = query.to_i64?
		if int_value
			lookup.find(int_value).to_json
		else
			{ status: "Understood #{query} as #{int_value}" }.to_json
		end
	end
end

Kemal.run
