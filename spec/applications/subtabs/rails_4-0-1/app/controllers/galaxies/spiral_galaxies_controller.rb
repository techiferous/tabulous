class Galaxies::SpiralGalaxiesController < ApplicationController
  before_action :set_galaxies_spiral_galaxy, only: [:show, :edit, :update, :destroy]

  # GET /galaxies/spiral_galaxies
  # GET /galaxies/spiral_galaxies.json
  def index
    @galaxies_spiral_galaxies = Galaxies::SpiralGalaxy.all
  end

  # GET /galaxies/spiral_galaxies/1
  # GET /galaxies/spiral_galaxies/1.json
  def show
  end

  # GET /galaxies/spiral_galaxies/new
  def new
    @galaxies_spiral_galaxy = Galaxies::SpiralGalaxy.new
  end

  # GET /galaxies/spiral_galaxies/1/edit
  def edit
  end

  # POST /galaxies/spiral_galaxies
  # POST /galaxies/spiral_galaxies.json
  def create
    @galaxies_spiral_galaxy = Galaxies::SpiralGalaxy.new(galaxies_spiral_galaxy_params)

    respond_to do |format|
      if @galaxies_spiral_galaxy.save
        format.html { redirect_to @galaxies_spiral_galaxy, notice: 'Spiral galaxy was successfully created.' }
        format.json { render action: 'show', status: :created, location: @galaxies_spiral_galaxy }
      else
        format.html { render action: 'new' }
        format.json { render json: @galaxies_spiral_galaxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /galaxies/spiral_galaxies/1
  # PATCH/PUT /galaxies/spiral_galaxies/1.json
  def update
    respond_to do |format|
      if @galaxies_spiral_galaxy.update(galaxies_spiral_galaxy_params)
        format.html { redirect_to @galaxies_spiral_galaxy, notice: 'Spiral galaxy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @galaxies_spiral_galaxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galaxies/spiral_galaxies/1
  # DELETE /galaxies/spiral_galaxies/1.json
  def destroy
    @galaxies_spiral_galaxy.destroy
    respond_to do |format|
      format.html { redirect_to galaxies_spiral_galaxies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_galaxies_spiral_galaxy
      @galaxies_spiral_galaxy = Galaxies::SpiralGalaxy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def galaxies_spiral_galaxy_params
      params.require(:galaxies_spiral_galaxy).permit(:name)
    end
end
