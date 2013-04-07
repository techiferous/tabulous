class Planets::RoguePlanetsController < ApplicationController
  before_action :set_planets_rogue_planet, only: [:show, :edit, :update, :destroy]

  # GET /planets/rogue_planets
  # GET /planets/rogue_planets.json
  def index
    @planets_rogue_planets = Planets::RoguePlanet.all
  end

  # GET /planets/rogue_planets/1
  # GET /planets/rogue_planets/1.json
  def show
  end

  # GET /planets/rogue_planets/new
  def new
    @planets_rogue_planet = Planets::RoguePlanet.new
  end

  # GET /planets/rogue_planets/1/edit
  def edit
  end

  # POST /planets/rogue_planets
  # POST /planets/rogue_planets.json
  def create
    @planets_rogue_planet = Planets::RoguePlanet.new(planets_rogue_planet_params)

    respond_to do |format|
      if @planets_rogue_planet.save
        format.html { redirect_to @planets_rogue_planet, notice: 'Rogue planet was successfully created.' }
        format.json { render action: 'show', status: :created, location: @planets_rogue_planet }
      else
        format.html { render action: 'new' }
        format.json { render json: @planets_rogue_planet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /planets/rogue_planets/1
  # PATCH/PUT /planets/rogue_planets/1.json
  def update
    respond_to do |format|
      if @planets_rogue_planet.update(planets_rogue_planet_params)
        format.html { redirect_to @planets_rogue_planet, notice: 'Rogue planet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @planets_rogue_planet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planets/rogue_planets/1
  # DELETE /planets/rogue_planets/1.json
  def destroy
    @planets_rogue_planet.destroy
    respond_to do |format|
      format.html { redirect_to planets_rogue_planets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planets_rogue_planet
      @planets_rogue_planet = Planets::RoguePlanet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def planets_rogue_planet_params
      params.require(:planets_rogue_planet).permit(:name)
    end
end
