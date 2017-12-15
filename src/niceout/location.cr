require "http/client"
require "json"

module Niceout
  class Location

    LOCAL_INFO_URL = "https://ipinfo.io/json"

    @lat : String = ""
    @lon : String = ""
    @zip_code : String = ""
    @city : String = ""

    getter zip_code, lat, lon, city

    def initialize
      response = HTTP::Client.get LOCAL_INFO_URL
      location_hash = JSON.parse response.body

      lat_lon = location_hash["loc"].to_s.split(",")
      @lat = lat_lon.first
      @lon = lat_lon.last
      @zip_code = location_hash["postal"].to_s
      @city = location_hash["city"].to_s
    end
  end
end
