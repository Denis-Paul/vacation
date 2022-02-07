class HomeController < ApplicationController
  def index
    @destinations = Destination.all
    # @destinations = Destination.joins(:reviews).group("destinations.id").order("avg(reviews.rating) desc")
    @destinations_weather_data = {}
    @destinations.each do |destination|
      city_weather = WeatherApiService.call(destination.city)
      @destinations_weather_data["#{destination.city}"] = city_weather
    end
  end
end
