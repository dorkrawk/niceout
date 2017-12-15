require "./niceout/*"
require "commander"
require "dotenv"

module Niceout
  cli = Commander::Command.new do |cmd|
    cmd.use = "niceout"
    cmd.long = "Is it nice out?"

    cmd.run do |options, arguments|
      arguments                # => Array(String)
      location = Niceout::Location.new
      weather = Niceout::Weather.new(location)
      puts "#{weather.weather_display} in #{location.city}"
    end
  end
  Commander.run(cli, ARGV)
end
