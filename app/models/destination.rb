class Destination < ApplicationRecord
    validates :city, presence: true, uniqueness: true
    validates :country, presence: true
    validates :currency, presence: true, length: { maximum: 3, message: "doesn't have a valid size" }
    
    def self.get_weather(city)
        @response =  RestClient.get "http://api.weatherapi.com/v1/current.json?q=#{city}", { content_type: :json, accept: :json, "key": ENV["WEATHER_API_KEY"] }
        # byebug
        @current_city_weather = JSON.parse(@response.body)["current"]
        @current_city_weather
    end
end
