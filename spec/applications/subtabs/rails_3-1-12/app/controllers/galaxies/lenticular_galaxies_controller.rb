class Galaxies::LenticularGalaxiesController < ApplicationController
  # GET /galaxies/lenticular_galaxies
  # GET /galaxies/lenticular_galaxies.json
  def index
    @galaxies_lenticular_galaxies = Galaxies::LenticularGalaxy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @galaxies_lenticular_galaxies }
    end
  end

  # GET /galaxies/lenticular_galaxies/1
  # GET /galaxies/lenticular_galaxies/1.json
  def show
    @galaxies_lenticular_galaxy = Galaxies::LenticularGalaxy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @galaxies_lenticular_galaxy }
    end
  end

  # GET /galaxies/lenticular_galaxies/new
  # GET /galaxies/lenticular_galaxies/new.json
  def new
    @galaxies_lenticular_galaxy = Galaxies::LenticularGalaxy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @galaxies_lenticular_galaxy }
    end
  end

  # GET /galaxies/lenticular_galaxies/1/edit
  def edit
    @galaxies_lenticular_galaxy = Galaxies::LenticularGalaxy.find(params[:id])
  end

  # POST /galaxies/lenticular_galaxies
  # POST /galaxies/lenticular_galaxies.json
  def create
    @galaxies_lenticular_galaxy = Galaxies::LenticularGalaxy.new(params[:galaxies_lenticular_galaxy])

    respond_to do |format|
      if @galaxies_lenticular_galaxy.save
        format.html { redirect_to @galaxies_lenticular_galaxy, notice: 'Lenticular galaxy was successfully created.' }
        format.json { render json: @galaxies_lenticular_galaxy, status: :created, location: @galaxies_lenticular_galaxy }
      else
        format.html { render action: "new" }
        format.json { render json: @galaxies_lenticular_galaxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /galaxies/lenticular_galaxies/1
  # PUT /galaxies/lenticular_galaxies/1.json
  def update
    @galaxies_lenticular_galaxy = Galaxies::LenticularGalaxy.find(params[:id])

    respond_to do |format|
      if @galaxies_lenticular_galaxy.update_attributes(params[:galaxies_lenticular_galaxy])
        format.html { redirect_to @galaxies_lenticular_galaxy, notice: 'Lenticular galaxy was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @galaxies_lenticular_galaxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galaxies/lenticular_galaxies/1
  # DELETE /galaxies/lenticular_galaxies/1.json
  def destroy
    @galaxies_lenticular_galaxy = Galaxies::LenticularGalaxy.find(params[:id])
    @galaxies_lenticular_galaxy.destroy

    respond_to do |format|
      format.html { redirect_to galaxies_lenticular_galaxies_url }
      format.json { head :ok }
    end
  end
end
