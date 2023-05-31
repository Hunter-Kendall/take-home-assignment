class LocationsController < ApplicationController
  before_action :set_location, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  # GET /locations or /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1 or /locations/1.json
  def show
    @locations = Location.all
  end

  # GET /locations/new
  def new
    #@location = Location.new
    @locations = Location.all
    @location = current_user.locations.build
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations or /locations.json
  def create
    #@location = Location.new(location_params)
    @location = current_user.locations.build(location_params)

    respond_to do |format|
      loc2 = Net::HTTP.get(URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{@location.city.to_s},#{@location.state.to_s},#{@location.zipcode.to_s}&key=#{Rails.application.credentials.dig(:google_api_key)}"))
      hash = JSON.parse(loc2)
      if hash["status"] == "ZERO_RESULTS"
        format.html { redirect_to location_url(new_location_path), notice: "Location not found."}
      else
        if @location.save
          format.html { redirect_to location_url(@location), notice: "Location was successfully created." }
          format.json { render :show, status: :created, location: @location }
        
        else
          format.html { redirect_to location_url(new_location_path), notice: "Please add a city and state.", class: "red"}
          #format.json { render json: @location.errors, status: :unprocessable_entity }
        end
        
      end
    end
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to location_url(@location), notice: "Location was successfully updated." }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: "Location was successfully destroyed." }
      format.json { head :no_content }
    end
  end



  def correct_user
    @user = current_user.locations.find_by(id: params[:id])
    redirect_to need_login_path notice: "You need to login to see other locations" if @user.nil?
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:city, :state, :zipcode, :user_id)
    end
end
