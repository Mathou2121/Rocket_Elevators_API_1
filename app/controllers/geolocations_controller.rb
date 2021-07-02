class GeolocationsController < ApplicationController
  before_action :set_geolocation, only: %i[ show edit update destroy ]

  # GET /geolocations or /geolocations.json
  def index
    @geolocations = Geolocation.all
  end

  # GET /geolocations/1 or /geolocations/1.json
  def show
  end

  # GET /geolocations/new
  def new
    @geolocation = Geolocation.new
  end

  # GET /geolocations/1/edit
  def edit
  end

  # POST /geolocations or /geolocations.json
  def create
    @geolocation = Geolocation.new(geolocation_params)

    respond_to do |format|
      if @geolocation.save
        format.html { redirect_to @geolocation, notice: "Geolocation was successfully created." }
        format.json { render :show, status: :created, location: @geolocation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @geolocation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /geolocations/1 or /geolocations/1.json
  def update
    respond_to do |format|
      if @geolocation.update(geolocation_params)
        format.html { redirect_to @geolocation, notice: "Geolocation was successfully updated." }
        format.json { render :show, status: :ok, location: @geolocation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @geolocation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /geolocations/1 or /geolocations/1.json
  def destroy
    @geolocation.destroy
    respond_to do |format|
      format.html { redirect_to geolocations_url, notice: "Geolocation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_geolocation
      @geolocation = Geolocation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def geolocation_params
      params.fetch(:geolocation, {})
    end
end
