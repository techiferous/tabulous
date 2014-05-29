class Planets::ExoplanetsController < ApplicationController
  before_action :set_planets_exoplanet, only: [:show, :edit, :update, :destroy]

  # GET /planets/exoplanets
  # GET /planets/exoplanets.json
  def index
    @planets_exoplanets = Planets::Exoplanet.all
  end

  # GET /planets/exoplanets/1
  # GET /planets/exoplanets/1.json
  def show
  end

  # GET /planets/exoplanets/new
  def new
    @planets_exoplanet = Planets::Exoplanet.new
  end

  # GET /planets/exoplanets/1/edit
  def edit
  end

  # POST /planets/exoplanets
  # POST /planets/exoplanets.json
  def create
    @planets_exoplanet = Planets::Exoplanet.new(planets_exoplanet_params)

    respond_to do |format|
      if @planets_exoplanet.save
        format.html { redirect_to @planets_exoplanet, notice: 'Exoplanet was successfully created.' }
        format.json { render action: 'show', status: :created, location: @planets_exoplanet }
      else
        format.html { render action: 'new' }
        format.json { render json: @planets_exoplanet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /planets/exoplanets/1
  # PATCH/PUT /planets/exoplanets/1.json
  def update
    respond_to do |format|
      if @planets_exoplanet.update(planets_exoplanet_params)
        format.html { redirect_to @planets_exoplanet, notice: 'Exoplanet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @planets_exoplanet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planets/exoplanets/1
  # DELETE /planets/exoplanets/1.json
  def destroy
    @planets_exoplanet.destroy
    respond_to do |format|
      format.html { redirect_to planets_exoplanets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planets_exoplanet
      @planets_exoplanet = Planets::Exoplanet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def planets_exoplanet_params
      params.require(:planets_exoplanet).permit(:name)
    end
end
