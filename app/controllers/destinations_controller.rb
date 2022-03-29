class DestinationsController < ApplicationController
  before_action :set_destination, only: %i[ show edit update destroy ]

  # GET /destinations or /destinations.json
  def index
    @destinations = Destination.all
  end

  # GET /destinations/1 or /destinations/1.json
  def show
    @city_weather = WeatherApiService.call(@destination.city)
    # TODO: handle errors ?
  end

  # GET /destinations/new
  def new
    @destination = Destination.new
  end

  # GET /destinations/1/edit
  def edit
  end

  # GET /destinations/filter
  def filter
    @destinations = Destination.filter(params[:country])
    if @destinations.empty?
      flash[:alert] = 'Country not found'
    else
      flash.clear # flash.discard
    end
    # TODO: extract logic for getting destination weather data in another class
    add_weather_attr
    render 'home/index'
    # respond_to do |format|
    #   format.html { render 'home/index' }
    #   format.js
    # end
  end

  # POST /destinations or /destinations.json
  def create
    @destination = Destination.new(destination_params)

    respond_to do |format|
      if @destination.save
        format.html { redirect_to destination_url(@destination), notice: "Destination was successfully created." }
        format.json { render :show, status: :created, location: @destination }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @destination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /destinations/1 or /destinations/1.json
  def update
    respond_to do |format|
      if @destination.update(destination_params)
        format.html { redirect_to destination_url(@destination), notice: "Destination was successfully updated." }
        format.json { render :show, status: :ok, location: @destination }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @destination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /destinations/1 or /destinations/1.json
  def destroy
    @destination.destroy

    respond_to do |format|
      format.html { redirect_to destinations_url, notice: "Destination was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_destination
      @destination = Destination.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def destination_params
      params.require(:destination).permit(:city, :country, :currency)
    end

    def add_weather_attr
      @destinations.each do |destination|
      api_response = WeatherApiService.call(destination.city)
      if api_response.is_a? String
        destination["weather"] = { error: api_response }
      else
        destination["weather"] = { data: api_response }
      end
    end
  end
end
