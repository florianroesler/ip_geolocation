require "sentry"

sentry = Sentry::ProcessRunner.new(
    display_name: "IP Geolocation API",
    build_command: "crystal build ./src/ip_geolocation_api.cr -o ./bin/ip_geolocation_api",
    run_command: "./bin/ip_geolocation_api",
    files: ["./src/*.cr"]
)

sentry.run
