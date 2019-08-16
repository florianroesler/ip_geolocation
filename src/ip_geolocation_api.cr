require "kemal"
require "http/client"
require "logger"
require "../src/lookup"
require "../src/ip_address"

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


get "/v1/locate" do |env|
	query = env.params.query.fetch("q", "").strip

	address = IPAddress.new(query)

	address_as_int = address.to_i64
	if address_as_int
		lookup.find(address_as_int).to_json
	else
		env.response.status_code = 422
		{ error: "Seems like you did not provide a valid IPv4 address or a corresponding integer representation." }.to_json
	end

end

Kemal.run
