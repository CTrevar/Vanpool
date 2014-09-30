class RetroaspectosController < ApplicationController
  # GET /retroaspectos
  # GET /retroaspectos.json
  def index
    @retroaspectos = Retroaspecto.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @retroaspectos }
    end
  end

  # GET /retroaspectos/1
  # GET /retroaspectos/1.json
  def show
    @retroaspecto = Retroaspecto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @retroaspecto }
    end
  end

  # GET /retroaspectos/new
  # GET /retroaspectos/new.json
  def new
    @retroaspecto = Retroaspecto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @retroaspecto }
    end
  end

  # GET /retroaspectos/1/edit
  def edit
    @retroaspecto = Retroaspecto.find(params[:id])
  end

  # POST /retroaspectos
  # POST /retroaspectos.json
  def create
    @retroaspecto = Retroaspecto.new(params[:retroaspecto])

    respond_to do |format|
      if @retroaspecto.save
        format.html { redirect_to @retroaspecto, notice: 'Retroaspecto was successfully created.' }
        format.json { render json: @retroaspecto, status: :created, location: @retroaspecto }
      else
        format.html { render action: "new" }
        format.json { render json: @retroaspecto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /retroaspectos/1
  # PUT /retroaspectos/1.json
  def update
    @retroaspecto = Retroaspecto.find(params[:id])

    respond_to do |format|
      if @retroaspecto.update_attributes(params[:retroaspecto])
        format.html { redirect_to @retroaspecto, notice: 'Retroaspecto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @retroaspecto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retroaspectos/1
  # DELETE /retroaspectos/1.json
  def destroy
    @retroaspecto = Retroaspecto.find(params[:id])
    @retroaspecto.destroy

    respond_to do |format|
      format.html { redirect_to retroaspectos_url }
      format.json { head :no_content }
    end
  end
end
