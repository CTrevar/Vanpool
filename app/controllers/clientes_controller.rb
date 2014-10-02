class ClientesController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :dashboard, 
    :profile, :muro, :reservaciones, :checkin, :retro, :reporte]

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

    #@openpay=OpenpayApi.new('muvdvkft3dzo57bfzv5g','sk_aa543af9dc964f83b41418a26aa6104f')
    #@customers=@openpay.create(:customers)
    #address_hash={
    #  "line1" => "Calle 10",
    #  "line2" => "col. san pablo",
    #  "line3" => "entre la calle 1 y la 2",
    #  "state" => "Queretaro",
    #  "city" => "Queretaro",
    #  "postal_code" => "76000",
    #  "country_code" => "MX"
    #}
    #request_hash={
    # "external_id" => nil,
    # "name" => "customer name",
    # "last_name" => nil,
    # "email" => "customer_email@me.com",
    # "requires_account" => true,
    # "phone_number" => "44209087654",
    # "address" => address_hash
    # }
    #response_hash=@customers.create(request_hash.to_hash)
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
    @co2 = @cliente.co2
    @kilometros = @cliente.kilometraje

    @reservaciones_pendientes=@current_cliente.reservacions.find_all_by_estadotipo_id(1)
    @reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2)
    @reservaciones_realizadas=@current_cliente.reservacions.find_all_by_estadotipo_id(3)

    @descuentos=obtener_ultimo_descuento(@cliente)

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
    @co2 = @cliente.co2
    @kilometros = @cliente.kilometraje
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

  def retro
    @title="Evalua el servicio"
    @current_cliente = obtener_cliente(current_user)
    @aspectos=aspectos

    render 'show_retro'
  end

  def reporte
    @title="Reporta el servicio"
    @current_cliente = obtener_cliente(current_user)
    @reporte = Reporte.new

    render 'show_reporte'
  end


  private
  end




