class DescuentosController < ApplicationController
  # GET /descuentos
  # GET /descuentos.json
  def index
    @descuentos = Descuento.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @descuentos }
    end
  end

  # GET /descuentos/1
  # GET /descuentos/1.json
  def show
    @descuento = Descuento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @descuento }
    end
  end

  # GET /descuentos/new
  # GET /descuentos/new.json
  def new
    @descuento = Descuento.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @descuento }
    end
  end

  # GET /descuentos/1/edit
  def edit
    @descuento = Descuento.find(params[:id])
  end

  # POST /descuentos
  # POST /descuentos.json
  def create
    @descuento = Descuento.new(params[:descuento])

    respond_to do |format|
      if @descuento.save
        format.html { redirect_to @descuento, notice: 'Descuento was successfully created.' }
        format.json { render json: @descuento, status: :created, location: @descuento }
      else
        format.html { render action: "new" }
        format.json { render json: @descuento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /descuentos/1
  # PUT /descuentos/1.json
  def update
    @descuento = Descuento.find(params[:id])

    respond_to do |format|
      if @descuento.update_attributes(params[:descuento])
        format.html { redirect_to @descuento, notice: 'Descuento was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @descuento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /descuentos/1
  # DELETE /descuentos/1.json
  def destroy
    @descuento = Descuento.find(params[:id])
    @descuento.destroy

    respond_to do |format|
      format.html { redirect_to descuentos_url }
      format.json { head :no_content }
    end
  end
end
