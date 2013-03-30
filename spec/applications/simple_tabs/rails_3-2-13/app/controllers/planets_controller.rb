class PlanetsController < ApplicationController
  # GET /planets
  # GET /planets.json
  def index
    @planets = Planet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @planets }
    end
  end

  # GET /planets/1
  # GET /planets/1.json
  def show
    @planet = Planet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @planet }
    end
  end

  # GET /planets/new
  # GET /planets/new.json
  def new
    @planet = Planet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @planet }
    end
  end

  # GET /planets/1/edit
  def edit
    @planet = Planet.find(params[:id])
  end

  # POST /planets
  # POST /planets.json
  def create
    @planet = Planet.new(params[:planet])

    respond_to do |format|
      if @planet.save
        format.html { redirect_to @planet, notice: 'Planet was successfully created.' }
        format.json { render json: @planet, status: :created, location: @planet }
      else
        format.html { render action: "new" }
        format.json { render json: @planet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /planets/1
  # PUT /planets/1.json
  def update
    @planet = Planet.find(params[:id])

    respond_to do |format|
      if @planet.update_attributes(params[:planet])
        format.html { redirect_to @planet, notice: 'Planet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @planet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planets/1
  # DELETE /planets/1.json
  def destroy
    @planet = Planet.find(params[:id])
    @planet.destroy

    respond_to do |format|
      format.html { redirect_to planets_url }
      format.json { head :no_content }
    end
  end
end
