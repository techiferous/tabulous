class Galaxies::EllipticalGalaxiesController < ApplicationController
  # GET /galaxies/elliptical_galaxies
  # GET /galaxies/elliptical_galaxies.json
  def index
    @galaxies_elliptical_galaxies = Galaxies::EllipticalGalaxy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @galaxies_elliptical_galaxies }
    end
  end

  # GET /galaxies/elliptical_galaxies/1
  # GET /galaxies/elliptical_galaxies/1.json
  def show
    @galaxies_elliptical_galaxy = Galaxies::EllipticalGalaxy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @galaxies_elliptical_galaxy }
    end
  end

  # GET /galaxies/elliptical_galaxies/new
  # GET /galaxies/elliptical_galaxies/new.json
  def new
    @galaxies_elliptical_galaxy = Galaxies::EllipticalGalaxy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @galaxies_elliptical_galaxy }
    end
  end

  # GET /galaxies/elliptical_galaxies/1/edit
  def edit
    @galaxies_elliptical_galaxy = Galaxies::EllipticalGalaxy.find(params[:id])
  end

  # POST /galaxies/elliptical_galaxies
  # POST /galaxies/elliptical_galaxies.json
  def create
    @galaxies_elliptical_galaxy = Galaxies::EllipticalGalaxy.new(params[:galaxies_elliptical_galaxy])

    respond_to do |format|
      if @galaxies_elliptical_galaxy.save
        format.html { redirect_to @galaxies_elliptical_galaxy, notice: 'Elliptical galaxy was successfully created.' }
        format.json { render json: @galaxies_elliptical_galaxy, status: :created, location: @galaxies_elliptical_galaxy }
      else
        format.html { render action: "new" }
        format.json { render json: @galaxies_elliptical_galaxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /galaxies/elliptical_galaxies/1
  # PUT /galaxies/elliptical_galaxies/1.json
  def update
    @galaxies_elliptical_galaxy = Galaxies::EllipticalGalaxy.find(params[:id])

    respond_to do |format|
      if @galaxies_elliptical_galaxy.update_attributes(params[:galaxies_elliptical_galaxy])
        format.html { redirect_to @galaxies_elliptical_galaxy, notice: 'Elliptical galaxy was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @galaxies_elliptical_galaxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galaxies/elliptical_galaxies/1
  # DELETE /galaxies/elliptical_galaxies/1.json
  def destroy
    @galaxies_elliptical_galaxy = Galaxies::EllipticalGalaxy.find(params[:id])
    @galaxies_elliptical_galaxy.destroy

    respond_to do |format|
      format.html { redirect_to galaxies_elliptical_galaxies_url }
      format.json { head :ok }
    end
  end
end
