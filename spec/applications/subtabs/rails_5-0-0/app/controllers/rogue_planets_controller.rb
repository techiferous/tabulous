class RoguePlanetsController < ApplicationController
  before_action :set_rogue_planet, only: [:show, :edit, :update, :destroy]

  # GET /rogue_planets
  # GET /rogue_planets.json
  def index
    @rogue_planets = RoguePlanet.all
  end

  # GET /rogue_planets/1
  # GET /rogue_planets/1.json
  def show
  end

  # GET /rogue_planets/new
  def new
    @rogue_planet = RoguePlanet.new
  end

  # GET /rogue_planets/1/edit
  def edit
  end

  # POST /rogue_planets
  # POST /rogue_planets.json
  def create
    @rogue_planet = RoguePlanet.new(rogue_planet_params)

    respond_to do |format|
      if @rogue_planet.save
        format.html { redirect_to @rogue_planet, notice: 'Rogue planet was successfully created.' }
        format.json { render :show, status: :created, location: @rogue_planet }
      else
        format.html { render :new }
        format.json { render json: @rogue_planet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rogue_planets/1
  # PATCH/PUT /rogue_planets/1.json
  def update
    respond_to do |format|
      if @rogue_planet.update(rogue_planet_params)
        format.html { redirect_to @rogue_planet, notice: 'Rogue planet was successfully updated.' }
        format.json { render :show, status: :ok, location: @rogue_planet }
      else
        format.html { render :edit }
        format.json { render json: @rogue_planet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rogue_planets/1
  # DELETE /rogue_planets/1.json
  def destroy
    @rogue_planet.destroy
    respond_to do |format|
      format.html { redirect_to rogue_planets_url, notice: 'Rogue planet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rogue_planet
      @rogue_planet = RoguePlanet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rogue_planet_params
      params.require(:rogue_planet).permit(:name)
    end
end
