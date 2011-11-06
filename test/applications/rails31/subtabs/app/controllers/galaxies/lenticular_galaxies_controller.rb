module Galaxies
  class LenticularGalaxiesController < ApplicationController
    # GET /lenticular_galaxies
    # GET /lenticular_galaxies.xml
    def index
      @lenticular_galaxies = LenticularGalaxy.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @lenticular_galaxies }
      end
    end

    # GET /lenticular_galaxies/1
    # GET /lenticular_galaxies/1.xml
    def show
      @lenticular_galaxy = LenticularGalaxy.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @lenticular_galaxy }
      end
    end

    # GET /lenticular_galaxies/new
    # GET /lenticular_galaxies/new.xml
    def new
      @lenticular_galaxy = LenticularGalaxy.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @lenticular_galaxy }
      end
    end

    # GET /lenticular_galaxies/1/edit
    def edit
      @lenticular_galaxy = LenticularGalaxy.find(params[:id])
    end

    # POST /lenticular_galaxies
    # POST /lenticular_galaxies.xml
    def create
      @lenticular_galaxy = LenticularGalaxy.new(params[:lenticular_galaxy])

      respond_to do |format|
        if @lenticular_galaxy.save
          format.html { redirect_to(galaxies_lenticular_galaxy_path(@lenticular_galaxy), :notice => 'Lenticular galaxy was successfully created.') }
          format.xml  { render :xml => @lenticular_galaxy, :status => :created, :location => @lenticular_galaxy }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @lenticular_galaxy.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /lenticular_galaxies/1
    # PUT /lenticular_galaxies/1.xml
    def update
      @lenticular_galaxy = LenticularGalaxy.find(params[:id])

      respond_to do |format|
        if @lenticular_galaxy.update_attributes(params[:lenticular_galaxy])
          format.html { redirect_to(galaxies_lenticular_galaxy_path(@lenticular_galaxy), :notice => 'Lenticular galaxy was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @lenticular_galaxy.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /lenticular_galaxies/1
    # DELETE /lenticular_galaxies/1.xml
    def destroy
      @lenticular_galaxy = LenticularGalaxy.find(params[:id])
      @lenticular_galaxy.destroy

      respond_to do |format|
        format.html { redirect_to(galaxies_lenticular_galaxies_url) }
        format.xml  { head :ok }
      end
    end
  end
end
