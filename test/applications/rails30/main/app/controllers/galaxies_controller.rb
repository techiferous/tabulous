class GalaxiesController < ApplicationController
  # GET /galaxies
  # GET /galaxies.xml
  def index
    @galaxies = Galaxy.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @galaxies }
    end
  end

  # GET /galaxies/1
  # GET /galaxies/1.xml
  def show
    @galaxy = Galaxy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @galaxy }
    end
  end

  # GET /galaxies/new
  # GET /galaxies/new.xml
  def new
    @galaxy = Galaxy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @galaxy }
    end
  end

  # GET /galaxies/1/edit
  def edit
    @galaxy = Galaxy.find(params[:id])
  end

  # POST /galaxies
  # POST /galaxies.xml
  def create
    @galaxy = Galaxy.new(params[:galaxy])

    respond_to do |format|
      if @galaxy.save
        format.html { redirect_to(@galaxy, :notice => 'Galaxy was successfully created.') }
        format.xml  { render :xml => @galaxy, :status => :created, :location => @galaxy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @galaxy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /galaxies/1
  # PUT /galaxies/1.xml
  def update
    @galaxy = Galaxy.find(params[:id])

    respond_to do |format|
      if @galaxy.update_attributes(params[:galaxy])
        format.html { redirect_to(@galaxy, :notice => 'Galaxy was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @galaxy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /galaxies/1
  # DELETE /galaxies/1.xml
  def destroy
    @galaxy = Galaxy.find(params[:id])
    @galaxy.destroy

    respond_to do |format|
      format.html { redirect_to(galaxies_url) }
      format.xml  { head :ok }
    end
  end
end
