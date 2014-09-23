class TipomedallasController < ApplicationController
  # GET /tipomedallas
  # GET /tipomedallas.json
  def index
    @tipomedallas = Tipomedalla.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tipomedallas }
    end
  end

  # GET /tipomedallas/1
  # GET /tipomedallas/1.json
  def show
    @tipomedalla = Tipomedalla.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tipomedalla }
    end
  end

  # GET /tipomedallas/new
  # GET /tipomedallas/new.json
  def new
    @tipomedalla = Tipomedalla.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tipomedalla }
    end
  end

  # GET /tipomedallas/1/edit
  def edit
    @tipomedalla = Tipomedalla.find(params[:id])
  end

  # POST /tipomedallas
  # POST /tipomedallas.json
  def create
    @tipomedalla = Tipomedalla.new(params[:tipomedalla])

    respond_to do |format|
      if @tipomedalla.save
        format.html { redirect_to @tipomedalla, notice: 'Tipomedalla was successfully created.' }
        format.json { render json: @tipomedalla, status: :created, location: @tipomedalla }
      else
        format.html { render action: "new" }
        format.json { render json: @tipomedalla.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tipomedallas/1
  # PUT /tipomedallas/1.json
  def update
    @tipomedalla = Tipomedalla.find(params[:id])

    respond_to do |format|
      if @tipomedalla.update_attributes(params[:tipomedalla])
        format.html { redirect_to @tipomedalla, notice: 'Tipomedalla was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tipomedalla.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipomedallas/1
  # DELETE /tipomedallas/1.json
  def destroy
    @tipomedalla = Tipomedalla.find(params[:id])
    @tipomedalla.destroy

    respond_to do |format|
      format.html { redirect_to tipomedallas_url }
      format.json { head :no_content }
    end
  end
end
