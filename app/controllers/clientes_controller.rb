class ClientesController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :dashboard, 
    :profile, :muro, :reservaciones, :checkin, :retro, :reporte, :create_retro, :guardaretro,
    :formapago, :compracredito, :buscarviaje]

  # GET /clientes
  # GET /clientes.json
  def index
    @clientes = Cliente.all
    @cliente = obtener_cliente
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clientes }
    end
  end

  # GET /clientes/1
  # GET /clientes/1.json
  def show
    @cliente = Cliente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cliente }
    end
  end

  # GET /clientes/new
  # GET /clientes/new.json
  def new
    @cliente = Cliente.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cliente }
    end
  end

  # GET /clientes/1/edit
  def edit
    #@cliente = Cliente.find(params[:id])
    #@cliente = obtener_cliente(current_user)
  end

  # POST /clientes
  # POST /clientes.json
  def create
    @cliente = Cliente.new(params[:cliente])
    respond_to do |format|
      if @cliente.save
        format.html { redirect_to @cliente, notice: 'Cliente was successfully created.' }
        format.json { render json: @cliente, status: :created, location: @cliente }
      else
        format.html { render action: "new" }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clientes/1
  # PUT /clientes/1.json
  def update
    @cliente = Cliente.find(params[:id])

    respond_to do |format|
      if @cliente.update_attributes(params[:cliente])
        format.html { redirect_to @cliente, notice: 'Cliente was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.json
  def destroy
    @cliente = Cliente.find(params[:id])
    @cliente.destroy

    respond_to do |format|
      format.html { redirect_to clientes_url }
      format.json { head :no_content }
    end
  end


  
  
  def dashboard
    @current_cliente = obtener_cliente(current_user)
    @reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2).last(3)
    @result=busqueda
    #@result=Viaje.all
    #puts @request_hash["name"]
    #print "hola"

  end


  def compracredito
    @current_cliente = obtener_cliente(current_user)
    
    #puts @request_hash["name"]
    #print "hola"
    render 'show_compra_credito'
  end

  def formapago
    @current_cliente = obtener_cliente(current_user)
    @recarga=params[:cantidad]
    @subtotal=subtotal(@recarga)
    @impuesto=impuesto(@recarga)
    #aspectos.each do |aspecto|
    #  calificacion=params[:"#{aspecto.id}"]
    #  retro = Retroalimentacion.create(reservacion_id:reservacion,aspecto_id:aspecto.id,calificacion:calificacion)
    #end
    #puts @request_hash["name"]
    #print "hola"
    render 'show_pago'
  end

  def subtotal(recarga)
    return (recarga.to_i-impuesto(recarga)).to_d
  end

  def impuesto(recarga)
    imp=Configuracion.find(2).valor
    return recarga.to_i*(imp.to_d/100)
  end

  def detalleviaje
    @current_cliente = obtener_cliente(current_user)
    
    #puts @request_hash["name"]
    #print "hola"
    render 'show_detalleviaje'
  end


  # GET /clientes/1/profile
  def profile
    @title = "Perfil"
    @user = User.find(params[:id])
    @current_cliente=Cliente.find_by_user_id(current_user.id)
    
    @cliente=obtener_cliente(@user)
    @mensaje=obtener_mensaje_nivel(@cliente)
    @validamedallas=valida_medallas(@cliente)
    @muro = obtener_ultimas_medallas(@cliente)
    @co2 = @cliente.co2ahorrado
    @kilometros = @cliente.kilometros

    @reservaciones_pendientes=@current_cliente.reservacions.find_all_by_estadotipo_id(1)
    @reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2)
    @reservaciones_realizadas=@current_cliente.reservacions.find_all_by_estadotipo_id(3)

    #@descuentos=obtener_ultimo_descuento(@cliente)

    render 'show_profile'
  end

  # GET /clientes/1/muro
  def muro
    @title="Muro de medallas"
    @user=User.find(params[:id])
    @current_cliente=Cliente.find_by_user_id(current_user.id)

    @cliente=obtener_cliente(@user)
    @mensaje=obtener_mensaje_nivel(@cliente)
    @validamedallas=valida_medallas(@cliente)
    @muro=obtener_muro(@cliente)
    @co2 = @cliente.co2ahorrado
    @kilometros = @cliente.kilometros
    render 'show_muro'
  end

  # GET /reservaciones
  def reservaciones
    @title="Reservaciones"
    @current_cliente = obtener_cliente(current_user)
    @validareservas=valida_viajes(@cliente)
    @validaviajes=valida_viajes_completos(@cliente)

    @reservaciones_pendientes=@current_cliente.reservacions.find_all_by_estadotipo_id(1)
    @reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2)
    @reservaciones_realizadas=@current_cliente.reservacions.find_all_by_estadotipo_id(3)
    @reservaciones_canceladas=@current_cliente.reservacions.find_all_by_estadotipo_id(4)
    
    render 'show_reservaciones'
  end


  def reporte
    @title="Reporta el servicio"
    @current_cliente = obtener_cliente(current_user)
    @reporte = Reporte.new

    render 'show_reporte'
  end

  def buscarviaje
    @title="Buscar nuevo viaje"
    @current_cliente = obtener_cliente(current_user)
    @reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2).last(3)
    
        #@result=Viaje.all
    render 'show_nuevo_viaje'
  end

  def procesarbusquedaviaje
    @origen=Localizacion.new
    @origen.longitud= params[:origenLng]
    @origen.latitud= params[:origenLat]

    @destino = Localizacion.new
    @destino.longitud = params[:destinoLng]
    @destino.latitud = params[:destinoLat]

    @result=busqueda(@origen, @destino)

    respond_to do |format|
        format.html { render partial: 'shared/user_rutas_busqueda', locals: { result: @result, origen: @origen }, layout:false}
        
    end
  end

  def comprar
    
    redirect_to :controller => 'clientes', :action => 'formapago'
  end

  end




