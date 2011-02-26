class SpiralGalaxiesController < ApplicationController
  # GET /spiral_galaxies
  # GET /spiral_galaxies.xml
  def index
    @spiral_galaxies = SpiralGalaxy.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @spiral_galaxies }
    end
  end

  # GET /spiral_galaxies/1
  # GET /spiral_galaxies/1.xml
  def show
    @spiral_galaxy = SpiralGalaxy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @spiral_galaxy }
    end
  end

  # GET /spiral_galaxies/new
  # GET /spiral_galaxies/new.xml
  def new
    @spiral_galaxy = SpiralGalaxy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @spiral_galaxy }
    end
  end

  # GET /spiral_galaxies/1/edit
  def edit
    @spiral_galaxy = SpiralGalaxy.find(params[:id])
  end

  # POST /spiral_galaxies
  # POST /spiral_galaxies.xml
  def create
    @spiral_galaxy = SpiralGalaxy.new(params[:spiral_galaxy])

    respond_to do |format|
      if @spiral_galaxy.save
        format.html { redirect_to(@spiral_galaxy, :notice => 'Spiral galaxy was successfully created.') }
        format.xml  { render :xml => @spiral_galaxy, :status => :created, :location => @spiral_galaxy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @spiral_galaxy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /spiral_galaxies/1
  # PUT /spiral_galaxies/1.xml
  def update
    @spiral_galaxy = SpiralGalaxy.find(params[:id])

    respond_to do |format|
      if @spiral_galaxy.update_attributes(params[:spiral_galaxy])
        format.html { redirect_to(@spiral_galaxy, :notice => 'Spiral galaxy was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @spiral_galaxy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /spiral_galaxies/1
  # DELETE /spiral_galaxies/1.xml
  def destroy
    @spiral_galaxy = SpiralGalaxy.find(params[:id])
    @spiral_galaxy.destroy

    respond_to do |format|
      format.html { redirect_to(spiral_galaxies_url) }
      format.xml  { head :ok }
    end
  end
end
