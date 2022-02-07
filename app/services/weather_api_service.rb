class WeatherApiService < ApplicationService
    attr_reader :city
    attr_accessor :errors

    def initialize(city)
      @city = city
    end
  
    def call
      get_weather
    end

    private

    def get_weather
      begin
        response =  RestClient.get "http://api.weatherapi.com/v1/current.json?q=#{@city}", { content_type: :json, accept: :json, "key": ENV["WEATHER_API_KEY"] }
        current_weather = JSON.parse(response.body, symbolize_names: true)
        current_weather[:current]
      rescue RestClient::ExceptionWithResponse => exception
        # response.code
        api_error_message = JSON.parse(exception.response, symbolize_names: true)[:error][:message]
        api_error_message
      # rescue => exception
        # exception.class.name
        # exception.message
      end
    end
end
