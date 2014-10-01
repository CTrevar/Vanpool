class ReportesController < ApplicationController
  # GET /reportes
  # GET /reportes.json
  def index
    @current_cliente = obtener_cliente(current_user)
    #@reportes = Reporte.find_all_by_estatus(true)
    @reportes = Reporte.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reportes }
    end
  end

  # GET /reportes/1
  # GET /reportes/1.json
  def show
    @current_cliente = obtener_cliente(current_user)
    @reporte = Reporte.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reporte }
    end
  end

  # GET /reportes/new
  # GET /reportes/new.json
  def new
    @current_cliente = obtener_cliente(current_user)
    @reporte = Reporte.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reporte }
    end
  end

  # GET /reportes/1/edit
  def edit
    @reporte = Reporte.find(params[:id])
  end

  # POST /reportes
  # POST /reportes.json
  def create
    @reporte = Reporte.new(params[:reporte])
    @reporte.cliente_id = obtener_cliente(current_user).id
    @reporte.estatus = true

    respond_to do |format|
      if @reporte.save
        format.html { redirect_to :controller => 'clientes', :action => 'dashboard', notice: 'Reporte was successfully created.' }
        format.json { render json: @reporte, status: :created, location: @reporte }
      else
        format.html { render action: "new" }
        format.json { render json: @reporte.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reportes/1
  # PUT /reportes/1.json
  def update
    @reporte = Reporte.find(params[:id])

    respond_to do |format|
      if @reporte.update_attributes(params[:reporte])
        format.html { redirect_to @reporte, notice: 'Reporte was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reporte.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reportes/1
  # DELETE /reportes/1.json
  def destroy
    @reporte = Reporte.find(params[:id])
    @reporte.destroy

    respond_to do |format|
      format.html { redirect_to reportes_url }
      format.json { head :no_content }
    end
  end
end
