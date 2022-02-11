class HomeController < ApplicationController

  def index
    @destinations = Destination.all
    add_weather_attr
  end

  private

    def add_weather_attr
        @destinations.each do |destination|
        client = GetCityWeatherData::Client.new(city: destination.city, api_key: ENV["WEATHER_API_KEY"])
        api_response = client.get_weather
        if api_response.is_a? String
          destination["weather"] = { error: api_response }
        else
          destination["weather"] = { data: api_response }
        end
      end
    end
end
