class Galaxies::EllipticalGalaxiesController < ApplicationController
  before_action :set_galaxies_elliptical_galaxy, only: [:show, :edit, :update, :destroy]

  # GET /galaxies/elliptical_galaxies
  # GET /galaxies/elliptical_galaxies.json
  def index
    @galaxies_elliptical_galaxies = Galaxies::EllipticalGalaxy.all
  end

  # GET /galaxies/elliptical_galaxies/1
  # GET /galaxies/elliptical_galaxies/1.json
  def show
  end

  # GET /galaxies/elliptical_galaxies/new
  def new
    @galaxies_elliptical_galaxy = Galaxies::EllipticalGalaxy.new
  end

  # GET /galaxies/elliptical_galaxies/1/edit
  def edit
  end

  # POST /galaxies/elliptical_galaxies
  # POST /galaxies/elliptical_galaxies.json
  def create
    @galaxies_elliptical_galaxy = Galaxies::EllipticalGalaxy.new(galaxies_elliptical_galaxy_params)

    respond_to do |format|
      if @galaxies_elliptical_galaxy.save
        format.html { redirect_to @galaxies_elliptical_galaxy, notice: 'Elliptical galaxy was successfully created.' }
        format.json { render action: 'show', status: :created, location: @galaxies_elliptical_galaxy }
      else
        format.html { render action: 'new' }
        format.json { render json: @galaxies_elliptical_galaxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /galaxies/elliptical_galaxies/1
  # PATCH/PUT /galaxies/elliptical_galaxies/1.json
  def update
    respond_to do |format|
      if @galaxies_elliptical_galaxy.update(galaxies_elliptical_galaxy_params)
        format.html { redirect_to @galaxies_elliptical_galaxy, notice: 'Elliptical galaxy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @galaxies_elliptical_galaxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galaxies/elliptical_galaxies/1
  # DELETE /galaxies/elliptical_galaxies/1.json
  def destroy
    @galaxies_elliptical_galaxy.destroy
    respond_to do |format|
      format.html { redirect_to galaxies_elliptical_galaxies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_galaxies_elliptical_galaxy
      @galaxies_elliptical_galaxy = Galaxies::EllipticalGalaxy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def galaxies_elliptical_galaxy_params
      params.require(:galaxies_elliptical_galaxy).permit(:name)
    end
end
