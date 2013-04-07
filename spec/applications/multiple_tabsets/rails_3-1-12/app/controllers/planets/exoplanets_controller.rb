class Planets::ExoplanetsController < ApplicationController
  # GET /planets/exoplanets
  # GET /planets/exoplanets.json
  def index
    @planets_exoplanets = Planets::Exoplanet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @planets_exoplanets }
    end
  end

  # GET /planets/exoplanets/1
  # GET /planets/exoplanets/1.json
  def show
    @planets_exoplanet = Planets::Exoplanet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @planets_exoplanet }
    end
  end

  # GET /planets/exoplanets/new
  # GET /planets/exoplanets/new.json
  def new
    @planets_exoplanet = Planets::Exoplanet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @planets_exoplanet }
    end
  end

  # GET /planets/exoplanets/1/edit
  def edit
    @planets_exoplanet = Planets::Exoplanet.find(params[:id])
  end

  # POST /planets/exoplanets
  # POST /planets/exoplanets.json
  def create
    @planets_exoplanet = Planets::Exoplanet.new(params[:planets_exoplanet])

    respond_to do |format|
      if @planets_exoplanet.save
        format.html { redirect_to @planets_exoplanet, :notice => 'Exoplanet was successfully created.' }
        format.json { render :json => @planets_exoplanet, :status => :created, :location => @planets_exoplanet }
      else
        format.html { render :action => "new" }
        format.json { render :json => @planets_exoplanet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /planets/exoplanets/1
  # PUT /planets/exoplanets/1.json
  def update
    @planets_exoplanet = Planets::Exoplanet.find(params[:id])

    respond_to do |format|
      if @planets_exoplanet.update_attributes(params[:planets_exoplanet])
        format.html { redirect_to @planets_exoplanet, :notice => 'Exoplanet was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @planets_exoplanet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /planets/exoplanets/1
  # DELETE /planets/exoplanets/1.json
  def destroy
    @planets_exoplanet = Planets::Exoplanet.find(params[:id])
    @planets_exoplanet.destroy

    respond_to do |format|
      format.html { redirect_to planets_exoplanets_url }
      format.json { head :ok }
    end
  end
end
