class PlanetsController < ApplicationController
  # GET /planets
  # GET /planets.xml
  def index
    @planets = Planet.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @planets }
    end
  end

  # GET /planets/1
  # GET /planets/1.xml
  def show
    @planet = Planet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @planet }
    end
  end

  # GET /planets/new
  # GET /planets/new.xml
  def new
    @planet = Planet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @planet }
    end
  end

  # GET /planets/1/edit
  def edit
    @planet = Planet.find(params[:id])
  end

  # POST /planets
  # POST /planets.xml
  def create
    @planet = Planet.new(params[:planet])

    respond_to do |format|
      if @planet.save
        format.html { redirect_to(@planet, :notice => 'Planet was successfully created.') }
        format.xml  { render :xml => @planet, :status => :created, :location => @planet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @planet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /planets/1
  # PUT /planets/1.xml
  def update
    @planet = Planet.find(params[:id])

    respond_to do |format|
      if @planet.update_attributes(params[:planet])
        format.html { redirect_to(@planet, :notice => 'Planet was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @planet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /planets/1
  # DELETE /planets/1.xml
  def destroy
    @planet = Planet.find(params[:id])
    @planet.destroy

    respond_to do |format|
      format.html { redirect_to(planets_url) }
      format.xml  { head :ok }
    end
  end
end
