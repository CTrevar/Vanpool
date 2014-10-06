class RetroalimentacionsController < ApplicationController
  # GET /retroalimentacions
  # GET /retroalimentacions.json
  def index
    @retroalimentacions = Retroalimentacion.all
    @current_cliente=obtener_cliente(current_user)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @retroalimentacions }
    end
  end

  # GET /retroalimentacions/1
  # GET /retroalimentacions/1.json
  def show
    @retroalimentacion = Retroalimentacion.find(params[:id])
    @current_cliente=obtener_cliente(current_user)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @retroalimentacion }
    end
  end

  # GET /retroalimentacions/new
  # GET /retroalimentacions/new.json
  def new
    @retroalimentacion = Retroalimentacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @retroalimentacion }
    end
  end

  # GET /retroalimentacions/1/edit
  def edit
    @retroalimentacion = Retroalimentacion.find(params[:id])
  end

  # POST /retroalimentacions
  # POST /retroalimentacions.json
  def create
    @retroalimentacion = Retroalimentacion.new(params[:retro])

    respond_to do |format|
      if @retroalimentacion.save
        format.html { redirect_to @retroalimentacion, notice: 'Retroalimentacion was successfully created.' }
        format.json { render json: @retroalimentacion, status: :created, location: @retroalimentacion }
      else
        format.html { render action: "new" }
        format.json { render json: @retroalimentacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /retroalimentacions/1
  # PUT /retroalimentacions/1.json
  def update
    @retroalimentacion = Retroalimentacion.find(params[:id])

    respond_to do |format|
      if @retroalimentacion.update_attributes(params[:retroalimentacion])
        format.html { redirect_to @retroalimentacion, notice: 'Retroalimentacion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @retroalimentacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retroalimentacions/1
  # DELETE /retroalimentacions/1.json
  def destroy
    @retroalimentacion = Retroalimentacion.find(params[:id])
    @retroalimentacion.destroy

    respond_to do |format|
      format.html { redirect_to retroalimentacions_url }
      format.json { head :no_content }
    end
  end


end
