require 'faraday'

class WeatherController < ApplicationController
  def index
    if params[:city].present?
      @city = params[:city]
      api_key = ENV['OPENWEATHER_API_KEY']
      response = Faraday.get("https://api.openweathermap.org/data/2.5/weather?q=#{@city}&appid=#{api_key}&units=metric")
      if response.success?
        @weather = JSON.parse(response.body)
      else
        @error = "City not found or API error"
      end
    end
    render json: @weather
  end
end
