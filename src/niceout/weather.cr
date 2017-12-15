module Niceout
  class Weather
    Dotenv.load

    APIKEY = ENV["OPEN_WEATHER_MAP_KEY"]

    @weather_hash : JSON::Any

    def initialize(location : Niceout::Location)
      @weather_hash = load_weather(location.lat, location.lon)
    end

    def load_weather(lat, lon)
      open_weather_lat_long_url = "api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&APPID=#{APIKEY}"
      response = HTTP::Client.get open_weather_lat_long_url
      weather_hash = JSON.parse(response.body)
      weather_hash
    end

    def weather_display
      temp_f = temp_k_to_f(@weather_hash["main"]["temp"])
      emoji = description_to_emoji(@weather_hash["weather"].first["main"])
      "#{emoji}  #{temp_f.to_i}°"
    end

    def temp_k_to_f(temp)
      (temp.to_s.to_f * (9.0 / 5)) - 459.67
    end

    def description_to_emoji(description)
      Niceout::EMOJI_MAP.fetch(description.to_s.downcase, Niceout::DEFAULT)
    end
  end
end
