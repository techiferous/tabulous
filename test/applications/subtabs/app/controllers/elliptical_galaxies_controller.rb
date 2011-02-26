class EllipticalGalaxiesController < ApplicationController
  # GET /elliptical_galaxies
  # GET /elliptical_galaxies.xml
  def index
    @elliptical_galaxies = EllipticalGalaxy.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @elliptical_galaxies }
    end
  end

  # GET /elliptical_galaxies/1
  # GET /elliptical_galaxies/1.xml
  def show
    @elliptical_galaxy = EllipticalGalaxy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @elliptical_galaxy }
    end
  end

  # GET /elliptical_galaxies/new
  # GET /elliptical_galaxies/new.xml
  def new
    @elliptical_galaxy = EllipticalGalaxy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @elliptical_galaxy }
    end
  end

  # GET /elliptical_galaxies/1/edit
  def edit
    @elliptical_galaxy = EllipticalGalaxy.find(params[:id])
  end

  # POST /elliptical_galaxies
  # POST /elliptical_galaxies.xml
  def create
    @elliptical_galaxy = EllipticalGalaxy.new(params[:elliptical_galaxy])

    respond_to do |format|
      if @elliptical_galaxy.save
        format.html { redirect_to(@elliptical_galaxy, :notice => 'Elliptical galaxy was successfully created.') }
        format.xml  { render :xml => @elliptical_galaxy, :status => :created, :location => @elliptical_galaxy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @elliptical_galaxy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /elliptical_galaxies/1
  # PUT /elliptical_galaxies/1.xml
  def update
    @elliptical_galaxy = EllipticalGalaxy.find(params[:id])

    respond_to do |format|
      if @elliptical_galaxy.update_attributes(params[:elliptical_galaxy])
        format.html { redirect_to(@elliptical_galaxy, :notice => 'Elliptical galaxy was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @elliptical_galaxy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /elliptical_galaxies/1
  # DELETE /elliptical_galaxies/1.xml
  def destroy
    @elliptical_galaxy = EllipticalGalaxy.find(params[:id])
    @elliptical_galaxy.destroy

    respond_to do |format|
      format.html { redirect_to(elliptical_galaxies_url) }
      format.xml  { head :ok }
    end
  end
end
