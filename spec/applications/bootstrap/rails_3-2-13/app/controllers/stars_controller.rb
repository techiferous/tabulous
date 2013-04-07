class StarsController < ApplicationController
  # GET /stars
  # GET /stars.json
  def index
    @stars = Star.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @stars }
    end
  end

  # GET /stars/1
  # GET /stars/1.json
  def show
    @star = Star.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @star }
    end
  end

  # GET /stars/new
  # GET /stars/new.json
  def new
    @star = Star.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @star }
    end
  end

  # GET /stars/1/edit
  def edit
    @star = Star.find(params[:id])
  end

  # POST /stars
  # POST /stars.json
  def create
    @star = Star.new(params[:star])

    respond_to do |format|
      if @star.save
        format.html { redirect_to @star, :notice => 'Star was successfully created.' }
        format.json { render :json => @star, :status => :created, :location => @star }
      else
        format.html { render :action => "new" }
        format.json { render :json => @star.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stars/1
  # PUT /stars/1.json
  def update
    @star = Star.find(params[:id])

    respond_to do |format|
      if @star.update_attributes(params[:star])
        format.html { redirect_to @star, :notice => 'Star was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @star.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stars/1
  # DELETE /stars/1.json
  def destroy
    @star = Star.find(params[:id])
    @star.destroy

    respond_to do |format|
      format.html { redirect_to stars_url }
      format.json { head :no_content }
    end
  end
end
