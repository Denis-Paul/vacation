class HomeController < ApplicationController

  def index
    @destinations = Destination.all
    add_weather_attr
  end

  private

    def add_weather_attr
      @destinations.each do |destination|
        response_weather_data = GetCityWeatherData.get_weather(destination.city)
        if response_weather_data.is_a? String
          destination["weather"] = { error: response_weather_data }
        else
          destination["weather"] = { data: response_weather_data[:weather] }
        end
      end
    end

end
