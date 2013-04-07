class Planets::RoguePlanetsController < ApplicationController
  # GET /planets/rogue_planets
  # GET /planets/rogue_planets.json
  def index
    @planets_rogue_planets = Planets::RoguePlanet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @planets_rogue_planets }
    end
  end

  # GET /planets/rogue_planets/1
  # GET /planets/rogue_planets/1.json
  def show
    @planets_rogue_planet = Planets::RoguePlanet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @planets_rogue_planet }
    end
  end

  # GET /planets/rogue_planets/new
  # GET /planets/rogue_planets/new.json
  def new
    @planets_rogue_planet = Planets::RoguePlanet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @planets_rogue_planet }
    end
  end

  # GET /planets/rogue_planets/1/edit
  def edit
    @planets_rogue_planet = Planets::RoguePlanet.find(params[:id])
  end

  # POST /planets/rogue_planets
  # POST /planets/rogue_planets.json
  def create
    @planets_rogue_planet = Planets::RoguePlanet.new(params[:planets_rogue_planet])

    respond_to do |format|
      if @planets_rogue_planet.save
        format.html { redirect_to @planets_rogue_planet, :notice => 'Rogue planet was successfully created.' }
        format.json { render :json => @planets_rogue_planet, :status => :created, :location => @planets_rogue_planet }
      else
        format.html { render :action => "new" }
        format.json { render :json => @planets_rogue_planet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /planets/rogue_planets/1
  # PUT /planets/rogue_planets/1.json
  def update
    @planets_rogue_planet = Planets::RoguePlanet.find(params[:id])

    respond_to do |format|
      if @planets_rogue_planet.update_attributes(params[:planets_rogue_planet])
        format.html { redirect_to @planets_rogue_planet, :notice => 'Rogue planet was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @planets_rogue_planet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /planets/rogue_planets/1
  # DELETE /planets/rogue_planets/1.json
  def destroy
    @planets_rogue_planet = Planets::RoguePlanet.find(params[:id])
    @planets_rogue_planet.destroy

    respond_to do |format|
      format.html { redirect_to planets_rogue_planets_url }
      format.json { head :ok }
    end
  end
end
