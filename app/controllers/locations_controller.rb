class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.json { render json: @location }
    end
  end

  # POST /locations.json
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        format.json { render json: @location, status: :created, location: @location }
      else
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.json { render json: @location }
      else
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.json { head :ok }
    end
  end
end
