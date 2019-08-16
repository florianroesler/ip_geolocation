require "kemal"
require "http/client"
require "logger"

Log = Logger.new(STDOUT)
Log.level = Logger::DEBUG

before_all do |env|
	env.response.content_type = "application/json"
end

get "/" do
	{ status: "Believe me I am still alive!" }.to_json
end

Kemal.run
