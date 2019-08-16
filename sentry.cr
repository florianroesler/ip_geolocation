require "sentry"

sentry = Sentry::ProcessRunner.new(
    display_name: "IP Geolocation API",
    build_command: "crystal build ./src/server.cr -o ./bin/server",
    run_command: "./bin/server",
    files: ["./src/*.cr"]
)

sentry.run
