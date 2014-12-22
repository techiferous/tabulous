class ExoplanetsController < ApplicationController
  before_action :set_exoplanet, only: [:show, :edit, :update, :destroy]

  # GET /exoplanets
  # GET /exoplanets.json
  def index
    @exoplanets = Exoplanet.all
  end

  # GET /exoplanets/1
  # GET /exoplanets/1.json
  def show
  end

  # GET /exoplanets/new
  def new
    @exoplanet = Exoplanet.new
  end

  # GET /exoplanets/1/edit
  def edit
  end

  # POST /exoplanets
  # POST /exoplanets.json
  def create
    @exoplanet = Exoplanet.new(exoplanet_params)

    respond_to do |format|
      if @exoplanet.save
        format.html { redirect_to @exoplanet, notice: 'Exoplanet was successfully created.' }
        format.json { render :show, status: :created, location: @exoplanet }
      else
        format.html { render :new }
        format.json { render json: @exoplanet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exoplanets/1
  # PATCH/PUT /exoplanets/1.json
  def update
    respond_to do |format|
      if @exoplanet.update(exoplanet_params)
        format.html { redirect_to @exoplanet, notice: 'Exoplanet was successfully updated.' }
        format.json { render :show, status: :ok, location: @exoplanet }
      else
        format.html { render :edit }
        format.json { render json: @exoplanet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exoplanets/1
  # DELETE /exoplanets/1.json
  def destroy
    @exoplanet.destroy
    respond_to do |format|
      format.html { redirect_to exoplanets_url, notice: 'Exoplanet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exoplanet
      @exoplanet = Exoplanet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exoplanet_params
      params.require(:exoplanet).permit(:name)
    end
end
