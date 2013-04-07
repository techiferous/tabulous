class Galaxies::LenticularGalaxiesController < ApplicationController
  # GET /galaxies/lenticular_galaxies
  # GET /galaxies/lenticular_galaxies.xml
  def index
    @galaxies_lenticular_galaxies = Galaxies::LenticularGalaxy.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @galaxies_lenticular_galaxies }
    end
  end

  # GET /galaxies/lenticular_galaxies/1
  # GET /galaxies/lenticular_galaxies/1.xml
  def show
    @galaxies_lenticular_galaxy = Galaxies::LenticularGalaxy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @galaxies_lenticular_galaxy }
    end
  end

  # GET /galaxies/lenticular_galaxies/new
  # GET /galaxies/lenticular_galaxies/new.xml
  def new
    @galaxies_lenticular_galaxy = Galaxies::LenticularGalaxy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @galaxies_lenticular_galaxy }
    end
  end

  # GET /galaxies/lenticular_galaxies/1/edit
  def edit
    @galaxies_lenticular_galaxy = Galaxies::LenticularGalaxy.find(params[:id])
  end

  # POST /galaxies/lenticular_galaxies
  # POST /galaxies/lenticular_galaxies.xml
  def create
    @galaxies_lenticular_galaxy = Galaxies::LenticularGalaxy.new(params[:galaxies_lenticular_galaxy])

    respond_to do |format|
      if @galaxies_lenticular_galaxy.save
        format.html { redirect_to(@galaxies_lenticular_galaxy, :notice => 'Lenticular galaxy was successfully created.') }
        format.xml  { render :xml => @galaxies_lenticular_galaxy, :status => :created, :location => @galaxies_lenticular_galaxy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @galaxies_lenticular_galaxy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /galaxies/lenticular_galaxies/1
  # PUT /galaxies/lenticular_galaxies/1.xml
  def update
    @galaxies_lenticular_galaxy = Galaxies::LenticularGalaxy.find(params[:id])

    respond_to do |format|
      if @galaxies_lenticular_galaxy.update_attributes(params[:galaxies_lenticular_galaxy])
        format.html { redirect_to(@galaxies_lenticular_galaxy, :notice => 'Lenticular galaxy was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @galaxies_lenticular_galaxy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /galaxies/lenticular_galaxies/1
  # DELETE /galaxies/lenticular_galaxies/1.xml
  def destroy
    @galaxies_lenticular_galaxy = Galaxies::LenticularGalaxy.find(params[:id])
    @galaxies_lenticular_galaxy.destroy

    respond_to do |format|
      format.html { redirect_to(galaxies_lenticular_galaxies_url) }
      format.xml  { head :ok }
    end
  end
end
