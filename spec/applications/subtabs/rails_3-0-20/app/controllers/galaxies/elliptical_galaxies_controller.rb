class Galaxies::EllipticalGalaxiesController < ApplicationController
  # GET /galaxies/elliptical_galaxies
  # GET /galaxies/elliptical_galaxies.xml
  def index
    @galaxies_elliptical_galaxies = Galaxies::EllipticalGalaxy.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @galaxies_elliptical_galaxies }
    end
  end

  # GET /galaxies/elliptical_galaxies/1
  # GET /galaxies/elliptical_galaxies/1.xml
  def show
    @galaxies_elliptical_galaxy = Galaxies::EllipticalGalaxy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @galaxies_elliptical_galaxy }
    end
  end

  # GET /galaxies/elliptical_galaxies/new
  # GET /galaxies/elliptical_galaxies/new.xml
  def new
    @galaxies_elliptical_galaxy = Galaxies::EllipticalGalaxy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @galaxies_elliptical_galaxy }
    end
  end

  # GET /galaxies/elliptical_galaxies/1/edit
  def edit
    @galaxies_elliptical_galaxy = Galaxies::EllipticalGalaxy.find(params[:id])
  end

  # POST /galaxies/elliptical_galaxies
  # POST /galaxies/elliptical_galaxies.xml
  def create
    @galaxies_elliptical_galaxy = Galaxies::EllipticalGalaxy.new(params[:galaxies_elliptical_galaxy])

    respond_to do |format|
      if @galaxies_elliptical_galaxy.save
        format.html { redirect_to(@galaxies_elliptical_galaxy, :notice => 'Elliptical galaxy was successfully created.') }
        format.xml  { render :xml => @galaxies_elliptical_galaxy, :status => :created, :location => @galaxies_elliptical_galaxy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @galaxies_elliptical_galaxy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /galaxies/elliptical_galaxies/1
  # PUT /galaxies/elliptical_galaxies/1.xml
  def update
    @galaxies_elliptical_galaxy = Galaxies::EllipticalGalaxy.find(params[:id])

    respond_to do |format|
      if @galaxies_elliptical_galaxy.update_attributes(params[:galaxies_elliptical_galaxy])
        format.html { redirect_to(@galaxies_elliptical_galaxy, :notice => 'Elliptical galaxy was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @galaxies_elliptical_galaxy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /galaxies/elliptical_galaxies/1
  # DELETE /galaxies/elliptical_galaxies/1.xml
  def destroy
    @galaxies_elliptical_galaxy = Galaxies::EllipticalGalaxy.find(params[:id])
    @galaxies_elliptical_galaxy.destroy

    respond_to do |format|
      format.html { redirect_to(galaxies_elliptical_galaxies_url) }
      format.xml  { head :ok }
    end
  end
end
