class ClientesController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :dashboard, 
    :profile, :muro, :reservaciones, :checkin]

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

  def checkin
    @cliente = obtener_cliente(current_user)
    @cliente.puntaje=@cliente.puntaje+500
    @cliente.save
    redirect_to :controller => 'clientes', :action => 'reservaciones'
  end
  
  def dashboard
    @current_cliente = obtener_cliente(current_user)
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
    @co2 = calcula_co2(@cliente)
    @kilometros = 200
    @litros = 30
    render 'show_profile'
  end

  # GET /clientes/1/profile
  def muro
    @title="Muro de medallas"
    @user=User.find(params[:id])
    @current_cliente=Cliente.find_by_user_id(current_user.id)

    @cliente=obtener_cliente(@user)
    @mensaje=obtener_mensaje_nivel(@cliente)
    @validamedallas=valida_medallas(@cliente)
    @muro=obtener_muro(@cliente)
    @co2 = calcula_co2(@cliente)
    @kilometros = 200
    @litros = 30
    render 'show_muro'
  end

  # GET /clientes/1/profile
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


  private
    #Obtener cliente del usuario
    def obtener_cliente(user)
      @cliente = Cliente.find_by_user_id(user.id)
    end

    #Obtener las ultimas 3 medallas del cliente
    def obtener_ultimas_medallas(cliente)
      return cliente.medallas.order("created_at DESC").last(3)
    end

    #obtener todo las medallas del cliente
    def obtener_muro(cliente)
      return cliente.medallas.order("created_at ASC").all
    end

    #Obtener el CO2 del cliente
    def calcula_co2(cliente)
      return(cliente.puntaje*196)/1000
    end

    ##NIVELES
    #Validar si el cliente esta en el último nivel del cliente
    def valida_ultimo_nivel(cliente)
      if cliente.nivel.id==Nivel.last.id 
        return true
      else
        return false
      end
    end

    #Obtener mensaje para el siguiente nivel del cliente
    def obtener_mensaje_nivel(cliente)
      if valida_ultimo_nivel(cliente)==false then
        return "Solo te faltan #{calcula_puntos_siguiente_nivel(cliente)} 
        para el nivel #{calcula_siguiente_nivel(cliente).nombre}" 
      end
    end

    #Calcula el siguiente nivel del cliente
    def calcula_siguiente_nivel(cliente)
        return Nivel.find(cliente.nivel.id+1)
    end
    
    #Calcula los puntos necesarios para el siguiente nivel del cliente
    def calcula_puntos_siguiente_nivel(cliente)
      return calcula_siguiente_nivel(cliente).rangomaximo-cliente.puntaje
    end

    ##MEDALLAS
    #Validar si el cliente tiene medallas
    def valida_medallas(cliente)
      if cliente.medallas.count==0 
        return false
      end
    end

    ##MEDALLAS
    #Validar si el cliente tiene medallas
    def valida_viajes(cliente)
      if cliente.reservacions.find_all_by_estadotipo_id(2).count==0 
        return false
      end
    end

    #Validar si el cliente tiene medallas
    def valida_viajes_completos(cliente)
      if cliente.reservacions.find_all_by_estadotipo_id(3).count==0 
        return false
      end
    end

end


