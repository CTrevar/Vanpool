class ReservacionsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :checkin]
  # GET /reservacions
  # GET /reservacions.json
  def index
    @reservacions = Reservacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservacions }
    end
  end

  # GET /reservacions/1
  # GET /reservacions/1.json
  def show
    @reservacion = Reservacion.find(params[:id])
    @current_cliente = obtener_cliente(current_user)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reservacion }
    end
  end

  # GET /reservacions/new
  # GET /reservacions/new.json
  def new
    @reservacion = Reservacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reservacion }
    end
  end

  # GET /reservacions/1/edit
  def edit
    @reservacion = Reservacion.find(params[:id])
  end

  # POST /reservacions
  # POST /reservacions.json
  def create
    @reservacion = Reservacion.new(params[:reservacion])

    respond_to do |format|
      if @reservacion.save
        format.html { redirect_to @reservacion, notice: 'Reservacion was successfully created.' }
        format.json { render json: @reservacion, status: :created, location: @reservacion }
      else
        format.html { render action: "new" }
        format.json { render json: @reservacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reservacions/1
  # PUT /reservacions/1.json
  def update
    @reservacion = Reservacion.find(params[:id])

    respond_to do |format|
      if @reservacion.update_attributes(params[:reservacion])
        format.html { redirect_to @reservacion, notice: 'Reservacion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reservacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservacions/1
  # DELETE /reservacions/1.json
  def destroy
    @reservacion = Reservacion.find(params[:id])
    @reservacion.destroy

    respond_to do |format|
      format.html { redirect_to reservacions_url }
      format.json { head :no_content }
    end
  end

def checkin
    @reservacion = Reservacion.find(params[:id])
    @reservacion.estadotipo_id=3
    @reservacion.cliente.puntaje=@reservacion.cliente.puntaje+5000
    @reservacion.cliente.kilometraje=@reservacion.cliente.kilometraje+@reservacion.viaje.ruta.kilometros
    if(@reservacion.cliente.puntaje>14999)then
      @reservacion.cliente.nivel_id=2
    end
    @reservacion.save
    @reservacion.cliente.save

    if(obtener_cliente(current_user).reservacions.find_all_by_estadotipo_id(3).count  ==1) then
      @medallamuro = Medallasmuro.create(cliente_id:obtener_cliente(current_user).id,medalla_id:1)
      @medallamuro.save
    end
    
    redirect_to :controller => 'clientes', :action => 'reservaciones'
  end

  def obtener_cliente(user)
      @cliente = Cliente.find_by_user_id(user.id)
    end

end
