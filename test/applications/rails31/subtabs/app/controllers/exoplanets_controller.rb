class ExoplanetsController < ApplicationController
  # GET /exoplanets
  # GET /exoplanets.xml
  def index
    @exoplanets = Exoplanet.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exoplanets }
    end
  end

  # GET /exoplanets/1
  # GET /exoplanets/1.xml
  def show
    @exoplanet = Exoplanet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exoplanet }
    end
  end

  # GET /exoplanets/new
  # GET /exoplanets/new.xml
  def new
    @exoplanet = Exoplanet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exoplanet }
    end
  end

  # GET /exoplanets/1/edit
  def edit
    @exoplanet = Exoplanet.find(params[:id])
  end

  # POST /exoplanets
  # POST /exoplanets.xml
  def create
    @exoplanet = Exoplanet.new(params[:exoplanet])

    respond_to do |format|
      if @exoplanet.save
        format.html { redirect_to(@exoplanet, :notice => 'Exoplanet was successfully created.') }
        format.xml  { render :xml => @exoplanet, :status => :created, :location => @exoplanet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exoplanet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exoplanets/1
  # PUT /exoplanets/1.xml
  def update
    @exoplanet = Exoplanet.find(params[:id])

    respond_to do |format|
      if @exoplanet.update_attributes(params[:exoplanet])
        format.html { redirect_to(@exoplanet, :notice => 'Exoplanet was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exoplanet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /exoplanets/1
  # DELETE /exoplanets/1.xml
  def destroy
    @exoplanet = Exoplanet.find(params[:id])
    @exoplanet.destroy

    respond_to do |format|
      format.html { redirect_to(exoplanets_url) }
      format.xml  { head :ok }
    end
  end
end
