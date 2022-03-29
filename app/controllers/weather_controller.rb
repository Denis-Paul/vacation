class WeatherController < ApplicationController
    def index
        @city_weather = nil
    end

    def search
        get_city_weather(params[:query])

        respond_to do |format|
            # format.html { redirect_to weather_index_path, notice: 'Weather data was found.' }
            format.html { render :index }
            format.js
            # if @city_weather
            #   format.js
            # else
            #   format.html { render :index }
            # end
        end

        # if @city_weather
        #     respond_to do |format|
        #         format.html { redirect_to weather_index_path, notice: 'Weather data was found.' }
        #         format.js
        #     end
        # end
    end

    private

    def get_city_weather(city)
        response_weather_data = GetCityWeatherData.get_weather(city)
        if response_weather_data.is_a? String
            @city_weather = { error: response_weather_data }
        else
            @city_weather = { data: response_weather_data[:weather], city: response_weather_data[:location][:name] }
        end
    end
end
