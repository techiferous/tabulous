class GalaxiesController < ApplicationController
  # GET /galaxies
  # GET /galaxies.json
  def index
    @galaxies = Galaxy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @galaxies }
    end
  end

  # GET /galaxies/1
  # GET /galaxies/1.json
  def show
    @galaxy = Galaxy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @galaxy }
    end
  end

  # GET /galaxies/new
  # GET /galaxies/new.json
  def new
    @galaxy = Galaxy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @galaxy }
    end
  end

  # GET /galaxies/1/edit
  def edit
    @galaxy = Galaxy.find(params[:id])
  end

  # POST /galaxies
  # POST /galaxies.json
  def create
    @galaxy = Galaxy.new(params[:galaxy])

    respond_to do |format|
      if @galaxy.save
        format.html { redirect_to @galaxy, notice: 'Galaxy was successfully created.' }
        format.json { render json: @galaxy, status: :created, location: @galaxy }
      else
        format.html { render action: "new" }
        format.json { render json: @galaxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /galaxies/1
  # PUT /galaxies/1.json
  def update
    @galaxy = Galaxy.find(params[:id])

    respond_to do |format|
      if @galaxy.update_attributes(params[:galaxy])
        format.html { redirect_to @galaxy, notice: 'Galaxy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @galaxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galaxies/1
  # DELETE /galaxies/1.json
  def destroy
    @galaxy = Galaxy.find(params[:id])
    @galaxy.destroy

    respond_to do |format|
      format.html { redirect_to galaxies_url }
      format.json { head :no_content }
    end
  end
end
