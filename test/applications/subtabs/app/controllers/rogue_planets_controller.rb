class RoguePlanetsController < ApplicationController
  # GET /rogue_planets
  # GET /rogue_planets.xml
  def index
    @rogue_planets = RoguePlanet.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rogue_planets }
    end
  end

  # GET /rogue_planets/1
  # GET /rogue_planets/1.xml
  def show
    @rogue_planet = RoguePlanet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rogue_planet }
    end
  end

  # GET /rogue_planets/new
  # GET /rogue_planets/new.xml
  def new
    @rogue_planet = RoguePlanet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rogue_planet }
    end
  end

  # GET /rogue_planets/1/edit
  def edit
    @rogue_planet = RoguePlanet.find(params[:id])
  end

  # POST /rogue_planets
  # POST /rogue_planets.xml
  def create
    @rogue_planet = RoguePlanet.new(params[:rogue_planet])

    respond_to do |format|
      if @rogue_planet.save
        format.html { redirect_to(@rogue_planet, :notice => 'Rogue planet was successfully created.') }
        format.xml  { render :xml => @rogue_planet, :status => :created, :location => @rogue_planet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rogue_planet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rogue_planets/1
  # PUT /rogue_planets/1.xml
  def update
    @rogue_planet = RoguePlanet.find(params[:id])

    respond_to do |format|
      if @rogue_planet.update_attributes(params[:rogue_planet])
        format.html { redirect_to(@rogue_planet, :notice => 'Rogue planet was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rogue_planet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rogue_planets/1
  # DELETE /rogue_planets/1.xml
  def destroy
    @rogue_planet = RoguePlanet.find(params[:id])
    @rogue_planet.destroy

    respond_to do |format|
      format.html { redirect_to(rogue_planets_url) }
      format.xml  { head :ok }
    end
  end
end
