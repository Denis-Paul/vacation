class HomeController < ApplicationController
  def index
    @destinations = Destination.all
    @destinations_weather_data = {}
    @destinations.each do |destination|
      city_weather = WeatherApiService.call(destination.city)
      @destinations_weather_data["#{destination.city}"] = city_weather
    end
  end
end
