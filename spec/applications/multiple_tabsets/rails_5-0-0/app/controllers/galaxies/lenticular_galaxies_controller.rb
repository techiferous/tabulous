class Galaxies::LenticularGalaxiesController < ApplicationController
  before_action :set_galaxies_lenticular_galaxy, only: [:show, :edit, :update, :destroy]

  # GET /galaxies/lenticular_galaxies
  # GET /galaxies/lenticular_galaxies.json
  def index
    @galaxies_lenticular_galaxies = Galaxies::LenticularGalaxy.all
  end

  # GET /galaxies/lenticular_galaxies/1
  # GET /galaxies/lenticular_galaxies/1.json
  def show
  end

  # GET /galaxies/lenticular_galaxies/new
  def new
    @galaxies_lenticular_galaxy = Galaxies::LenticularGalaxy.new
  end

  # GET /galaxies/lenticular_galaxies/1/edit
  def edit
  end

  # POST /galaxies/lenticular_galaxies
  # POST /galaxies/lenticular_galaxies.json
  def create
    @galaxies_lenticular_galaxy = Galaxies::LenticularGalaxy.new(galaxies_lenticular_galaxy_params)

    respond_to do |format|
      if @galaxies_lenticular_galaxy.save
        format.html { redirect_to @galaxies_lenticular_galaxy, notice: 'Lenticular galaxy was successfully created.' }
        format.json { render :show, status: :created, location: @galaxies_lenticular_galaxy }
      else
        format.html { render :new }
        format.json { render json: @galaxies_lenticular_galaxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /galaxies/lenticular_galaxies/1
  # PATCH/PUT /galaxies/lenticular_galaxies/1.json
  def update
    respond_to do |format|
      if @galaxies_lenticular_galaxy.update(galaxies_lenticular_galaxy_params)
        format.html { redirect_to @galaxies_lenticular_galaxy, notice: 'Lenticular galaxy was successfully updated.' }
        format.json { render :show, status: :ok, location: @galaxies_lenticular_galaxy }
      else
        format.html { render :edit }
        format.json { render json: @galaxies_lenticular_galaxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galaxies/lenticular_galaxies/1
  # DELETE /galaxies/lenticular_galaxies/1.json
  def destroy
    @galaxies_lenticular_galaxy.destroy
    respond_to do |format|
      format.html { redirect_to galaxies_lenticular_galaxies_url, notice: 'Lenticular galaxy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_galaxies_lenticular_galaxy
      @galaxies_lenticular_galaxy = Galaxies::LenticularGalaxy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def galaxies_lenticular_galaxy_params
      params.require(:galaxies_lenticular_galaxy).permit(:name)
    end
end
