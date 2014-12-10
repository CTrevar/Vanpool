class ClientesController < ApplicationController

  before_filter :authenticate_user!, only: [:index, :edit, :update, :destroy, :dashboard, 
    :profile, :muro, :reservaciones, :checkin, :retro, :reporte, :create_retro, :guardaretro,
    :formapago, :compracredito, :buscarviaje],
  except:[:jtable_list, :jtable_filterlist, :jtable_delete, :jtable_create, :jtable_update]

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
    @user = User.find(params[:id])
    @current_cliente = obtener_cliente(current_user)
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

    @user = current_user
    if Cliente.find_by_user_id(current_user.id).nil?
      @cliente = Cliente.create(puntaje:0,nivel_id:1,user_id:@user.id)
      #flash[:success] = "Welcome to the Sample App!"
      # Tell the UserMailer to send a welcome email after save
      UserMailer.welcome_email(@user).deliver

      @openpay=OpenpayApi.new('muvdvkft3dzo57bfzv5g','sk_aa543af9dc964f83b41418a26aa6104f')
   
      @customers=@openpay.create(:customers)
        request_hash={
          "external_id" => nil,
          "name" => @cliente.user.name,
          "last_name" => nil,
          "email" => @cliente.user.email,
          "requires_account" => true,
        }
        response_hash=@customers.create(request_hash.to_hash)
        @cliente.openpay_id=response_hash["id"]
        @cliente.save
        redirect_to :controller => 'clientes', :action => 'dashboard'
    end

 
    @current_cliente=obtener_cliente(current_user)
    @mensaje=obtener_mensaje_nivel(@current_cliente)
    
    @validamedallas=valida_medallas(@current_cliente)
    @muro = obtener_ultimas_medallas(@current_cliente)
    @co2 = calcula_co2ahorrado(@current_cliente)

    tabla_lideres(@current_cliente)
    @validareservas=valida_viajes(@cliente)
    #@reservaciones_pendientes=@current_cliente.reservacions.find_all_by_estadotipo_id(1)
    #@reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2)
    @reservaciones_pagadas=@current_cliente.reservacions.joins(:viaje).where('(estadotipo_id=2) and (estadoviaje_id=1 and fecha>?)', Time.now).order("fecha ASC").limit(3)
    
    @disponibilidad_pagadas = []
    @reservaciones_pagadas.each do |reserva_pagada|
      @disponibilidad_pagadas<< calcula_disponibilidad_viaje(reserva_pagada.viaje)
    end


    #@reservaciones_realizadas=@current_cliente.reservacions.find_all_by_estadotipo_id(3)
    #@reservaciones_canceladas=@current_cliente.reservacions.find_all_by_estadotipo_id(4)

    if(current_user.provider)
    @oauth = Koala::Facebook::OAuth.new("708292565932035", "0961c370c701538ac20f349b9a02b4b3")
    facebook_user_token = session[:access_token]
    @graph = Koala::Facebook::API.new(facebook_user_token)
    
    #valida cuando no sea feacebook el provider
    @picture = @graph.get_picture("me")
    @profile = @graph.get_object("me")
    @friends = @graph.get_connections("me", "friends")

    friendsvanpool=Array.new
    clientesvanpool=Array.new
    @friends.each do |friend| 
      friendsvanpool<<User.find_by_uid(friend["id"])
    end

    friendsvanpool.each do |f|
      clientesvanpool<<Cliente.find_by_user_id(f.id)
    end
    
    tabla_lideres_facebook(@current_cliente, Cliente.where(id: clientesvanpool.map(&:id)))

    else
    tabla_lideres(@current_cliente)
    end


    @regalos=obtener_regalos(@current_cliente).last(2)
    @promociones=obtener_promociones(@current_cliente).last(2)

  end

  def compartir_facebook
    @current_cliente = obtener_cliente(current_user)
    reservacion=Reservacion.find(params[:id])
    @oauth = Koala::Facebook::OAuth.new("708292565932035", "0961c370c701538ac20f349b9a02b4b3")
    facebook_user_token = session[:access_token]
    @graph = Koala::Facebook::API.new(facebook_user_token)
    @graph.put_wall_post("Yo ya uso la ruta #{reservacion.viaje.ruta.nombre} de Vanpool, ¿Y tú? http://vanpool.mx",{"picture"=>"http://104.236.6.99/assets/medals/viaje6-01.png"})
    Share.create(reservacion_id:reservacion.id)
    aumenta_puntos(@current_cliente,50)
    redirect_to mis_viajes_path
  end

  def promociones
    #@title="Muro de medallas"
    #@user=User.find(params[:id])
    #@current_cliente=Cliente.find_by_user_id(current_user.id)

    @current_cliente = obtener_cliente(current_user)
    @promociones=obtener_promociones(@current_cliente)
    @regalos=obtener_regalos(@current_cliente)
    render 'show_promociones'
  end

  def compracredito
    @current_cliente = obtener_cliente(current_user)
    # @response_hash = {
    #     id:"trrtxbcwh7808slobw12",
    #     amount:50.0,
    #     authorization:"801585",
    #     method:"card",
    #     operation_type:"in",
    #     transaction_type:"charge",
    #     card:{
    #         type:"debit",
    #         brand:"visa",
    #         address:nil,
    #         card_number:"411111XXXXXX1111",
    #         holder_name:"Alvaro",
    #         expiration_year:"20",
    #         expiration_month:"12",
    #         allows_charges:true,
    #         allows_payouts:true,
    #         bank_name:"Banamex",
    #         bank_code:"002"
    #     },
    #     status:"completed",
    #     conciliated:false,
    #     currency:"MXN",
    #     creation_date:"2014-12-07T01:18:14-06:00",
    #     operation_date:"2014-12-07T01:18:15-06:00",
    #     description:"Recarga de saldo por $50",
    #     error_message:nil,
    #     order_id:nil,
    #     customer_id:"axkqdhljhlvrmf9nu9fb",
    #     metadata:{
    #         iva:"16",
    #         subtotal:"42.0",
    #         impuesto:"8.0"
    #     },
    #     fee:{
    #         amount:3.45,
    #         tax:0.55
    #     }
    # }
    render 'show_compra_credito'
  end

  def formapago
    # @formapago = params[:forma]
    # @recarga = params[:cantidad]
    # @current_cliente = obtener_cliente(current_user)
    # @subtotal=subtotal(@recarga)
    # @impuesto=impuesto(@recarga)
    # @monto = @recarga
    # render 'show_compra_credito_tarjeta'
    # case @formapago
    #   when 'banco'
    #     render 'show_compra_credito_banco'
    #   when 'tarjeta'
    #     render 'show_compra_credito_tarjeta'
    #   when 'tienda'
    #     render 'show_compra_credito_tienda'
    #   else
    #     render 'show_pago'
    # end
  end

  def create_transaction_charge
    if !params[:token_id].present?
      redirect_to :controller => 'clientes', :action => 'compracredito'
    else
      @cuenta = obtener_cuenta
      @charges = @openpay.create(:charges)
      @current_cliente=Cliente.find_by_user_id(current_user.id)
      monto = params[:amount]
      iva = Configuracion.find_by_nombre("impuesto").valor
      # impuestos = (iva/100)*monto
      # subtotal = monto - impuestos

      request_hash={
          "method" => "card",
          "source_id" => params[:token_id],
          "amount" => monto,
          "description" => "Recarga de saldo por $#{params[:amount]}",
          "device_session_id" => params[:deviceIdHiddenFieldName],
          "metadata" => {
              "iva" => iva,
              "subtotal" => subtotal(monto),
              "impuesto" => impuesto(monto)
          }
      }
      begin
        @response_hash=@charges.create(request_hash.to_hash,@cuenta["id"])
        UserMailer.enviar_email_pago(@response_hash,@current_cliente).deliver
      rescue OpenpayTransactionException => @exception

      rescue OpenpayException => @exception

      rescue OpenpayConnectionException => @exception

      rescue Net::SMTPFatalError => e
        logger.error("Erro al enviar correo #{e.message}")
      end
    end
  end

  def subtotal(recarga)
    return (recarga.to_f-impuesto(recarga)).to_d
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
  #def profile
  #  @title = "Perfil"
  #  @user = User.find(params[:id])
  #  @current_cliente=Cliente.find_by_user_id(current_user.id)
    
  #  @cliente=obtener_cliente(@user)
  #  @mensaje=obtener_mensaje_nivel(@cliente)
  #  @validamedallas=valida_medallas(@cliente)
  #  @muro = obtener_ultimas_medallas(@cliente)
  #  @co2 = @cliente.co2ahorrado
  #  @kilometros = @cliente.kilometraje

  #  @reservaciones_pendientes=@current_cliente.reservacions.find_all_by_estadotipo_id(1)
  #  @disponibilidad_pendientes = []
  #  @reservaciones_pendientes.each do |reserva_pendiente|
  #    @disponibilidad_pendientes<< calcula_disponibilidad_viaje(reserva_pendiente.viaje)
  #  end

  #  @reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2)
  #  @disponibilidad_pagadas = []
  #  @reservaciones_pagadas.each do |reserva_pagada|
  #    @disponibilidad_pagadas<< calcula_disponibilidad_viaje(reserva_pagada.viaje)
  #  end

  #  @reservaciones_realizadas=@current_cliente.reservacions.find_all_by_estadotipo_id(3)

  #  @disponibilidad_pagadas = []
  #  @reservaciones_pagadas.each do |reserva_pagada|
  #    @disponibilidad_pagadas<< calcula_disponibilidad_viaje(reserva_pagada.viaje)
  #  end

    #@descuentos=obtener_ultimo_descuento(@cliente)

  #  render 'show_profile'
  #end

  # GET /clientes/1/muro
  def muro
    @title="Muro de medallas"
    @user=User.find(params[:id])
    @current_cliente=Cliente.find_by_user_id(current_user.id)

    @cliente=obtener_cliente(@user)
    @mensaje=obtener_mensaje_nivel(@cliente)
    @validamedallas=valida_medallas(@cliente)
    @muro=obtener_muro(@cliente)
    @lider=obtener_lider(@cliente)
    
    render 'show_muro'
  end

  # GET /viajes
  def viajes
    @title="Mis Viajes"
    @current_cliente = obtener_cliente(current_user)
    @validareservas=valida_viajes(@cliente)
    @validaviajes=valida_viajes_completos(@cliente)

    @reservaciones_pendientes=@current_cliente.reservacions.find_all_by_estadotipo_id(1)
    @disponibilidad_pendientes = []
    @reservaciones_pendientes.each do |reserva_pendiente|
      @disponibilidad_pendientes<< calcula_disponibilidad_viaje(reserva_pendiente.viaje)
    end

    #@reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2)
    #@reservaciones_pagadas=@current_cliente.reservacions.joins(:viaje).where('estadotipo_id=3 or estadoviaje_id=1 or fecha>?', Time.now).last(3)
    @reservaciones_pagadas=@current_cliente.reservacions.joins(:viaje).where('(estadotipo_id=2) and (estadoviaje_id=1 and fecha>?)', Time.now)

    @disponibilidad_pagadas = []
    @reservaciones_pagadas.each do |reserva_pagada|
      @disponibilidad_pagadas<< calcula_disponibilidad_viaje(reserva_pagada.viaje)
    end

    @reservaciones_realizadas=@current_cliente.reservacions.find_all_by_estadotipo_id(3)
    #@reservaciones_canceladas=@current_cliente.reservacions.find_all_by_estadotipo_id(4)
    
    render 'show_viajes'
  end

  # GET /reservaciones
  # def reservaciones
  #   @title="Mis Reservas"
  #   @current_cliente = obtener_cliente(current_user)
  #   @validareservas=valida_viajes(@cliente)
  #   @validaviajes=valida_viajes_completos(@cliente)

  #   @reservaciones_pendientes=@current_cliente.reservacions.find_all_by_estadotipo_id(1)
  #   @disponibilidad_pendientes = []
  #   @reservaciones_pendientes.each do |reserva_pendiente|
  #     @disponibilidad_pendientes<< calcula_disponibilidad_viaje(reserva_pendiente.viaje)
  #   end
    
  #   render 'show_reservaciones'
  # end


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
    @origenDireccion = params[:origenRuta]

    @destino = Localizacion.new
    @destino.longitud = params[:destinoLng]
    @destino.latitud = params[:destinoLat]
    @destinoDireccion = params[:destinoRuta]

    @result=busqueda(@origen, @destino)

    if @result.blank?
      create_sugerencia(@origen, @destino, @origenDireccion, @destinoDireccion)
    end

    respond_to do |format|
        format.html { render partial: 'shared/user_rutas_busqueda', locals: { result: @result, horainicio: @horainicio }, layout:false}
        
    end
  end

  def comprar
    
    redirect_to :controller => 'clientes', :action => 'formapago'
  end


  def buscar_viaje_zona
    @title="Viajes de la semana"
    @current_cliente = obtener_cliente(current_user)
    @reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2).last(3)

    viajes = Viaje.where("estadoviaje_id = 2 or estadoviaje_id = 1")
    @result = []
    ahora = Time.now.beginning_of_day
    una_semana = (ahora + 1.week).end_of_day
    
    viajes.each do |viaje|
      
      fecha_viaje = viaje.fecha.to_time

      #si está entre 2 fechas, se agrega al arreglo de viajes por zona encontrados
      if fecha_viaje <= una_semana and fecha_viaje >= ahora
           @result << viaje
      end
    end

    render 'buscar_zona'
  end

  def listar_rutas
    @title="Buscar Rutas"
    @current_cliente = obtener_cliente(current_user)
    @reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2).last(3)
    
    @result = Ruta.where("estatus = 't'")

    render 'buscar_zona'

  end

  def listar_rutas_zona
    filtro_zona_id = params[:zona_id]
    @result = []

    if filtro_zona_id.blank?
      @result = Ruta.where("estatus = 't'")
    else
      @result = Ruta.where("estatus = 't' and zona_id = ?", filtro_zona_id)
    end


    respond_to do |format|
        #Enviar viajes resultantes
        format.html { render partial: 'shared/user_rutas_zona', locals: { result: @result}, layout:false}
        
    end
      
  end

  def cliente_detalleruta

      @ruta= Ruta.find(params[:ruta_id])
      @paradas = @ruta.paradas.order('posicion ASC')
      @origen = @paradas.first
      @destino = @paradas.last
      
      @tiempoParadas = []
      @paradas.each_with_index do |parada, i|
        if i == 0
          @tiempoParadas << 0
        elsif i<=@paradas.count
          parada_id = parada.id
          tiempo = Rutaparada.find_by_ruta_id_and_parada_id(@ruta.id, parada_id).tiempo
          @tiempoParadas<< (@tiempoParadas[i-1]+tiempo.to_i)        
        end
      end


      respond_to do |format|
        format.html {render partial: 'shared/user_detalleruta', locals: { ruta: @ruta, origen: @origen, destino: @destino, paradas: @paradas, tiempoParadas: @tiempoParadas }}
      end
  end


  def mostrar_proximos_viajes
    @title="Viajes de la semana"
    @current_cliente = obtener_cliente(current_user)
    @reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2).last(3)

    @reservaciones_proximas = Reservacion.joins(:viaje).where("cliente_id= ? AND (estadotipo_id= 1 or estadotipo_id = 2) ", @current_cliente.id)
    render 'proximos_viajes'
  end

  def mostrar_viajes_realizados
    render 'viajes realizados'
  end

  def mostrar_rutas
    @title="Rutas"
    @current_cliente = obtener_cliente(current_user)
    @reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2).last(3)

    rutas = Ruta.where("estatus = 't'")
    viajes = Viaje.where("estadoviaje_id = 2 or estadoviaje_id = 1")
    @result = []
    ahora = Time.now.beginning_of_day
    una_semana = (ahora + 1.week).end_of_day
    
    viajes.each do |viaje|
      
      fecha_viaje = viaje.fecha.to_time

      #si está entre 2 fechas, se agrega al arreglo de viajes por zona encontrados
      if fecha_viaje <= una_semana and fecha_viaje >= ahora
           @result << viaje
      end
    end

    render 'buscar_zona'
  end


  def comprar_viajes
    @title = "Compra de Viajes"

    @ruta = Ruta.find(params[:id])
    @cantidad = params[:cantidad].to_i


    hoy = DateTime.now.beginning_of_day
    @viajes = Viaje.where("ruta_id = ? and estadoviaje_id = 1 and fecha > ?", @ruta.id, hoy)
    @disponibilidad = []

    if !@viajes.blank?
      #quitar los viajes que son del mismo día, pero en una hora que ya pasó
      @viajes.delete_if {|viaje| viaje.fecha.beginning_of_day.utc.strftime("%d%m%Y")==DateTime.now.beginning_of_day.utc.strftime("%d%m%Y") and viaje.horainicio.utc.strftime("%H%M%S%N") <= DateTime.now.utc.strftime("%H%M%S%N")}
      @viajes = @viajes.take(@cantidad) 
      @viajes.each do |viaje|
        @disponibilidad<<calcula_disponibilidad_viaje(viaje)
      end
    end

    respond_to do |format|
        format.html {render partial: 'shared/user_rutas_viajes', locals: { viajes: @viajes }, layout:false}
    end
    #render 'comprar_viajes'
  end


  def reservar_viajes
    current_cliente = obtener_cliente(current_user)
    cantidad_viajes = params[:cantidad].to_i
    cantidad_viajes_seleccionados = 0
    cantidad_viajes.times do |index|
      checked=params[:"check_viaje_#{index}"]
      if checked
        cantidad_viajes_seleccionados += 1
      end
    end

    costo_por_viaje = Ruta.find(params[:id]).precio.to_f
    cantidad_pago = cantidad_viajes_seleccionados*costo_por_viaje

    #checar si tiene saldo suficiente
    tiene_saldo= valida_saldo_suficiente(cantidad_pago)

    if tiene_saldo
        referenciapago=compra(cantidad_pago)
    end

    #si no hay saldo
    if !tiene_saldo
      session[:reservaciones] =  Array.new if !session[:reservaciones]
    end

    cantidad_viajes.times do |index|
      checked=params[:"check_viaje_#{index}"]
      if checked
        viaje_id = params[:"viaje_#{index}"]
        reserva = Reservacion.new
        reserva.viaje_id = viaje_id
        reserva.cliente_id = current_cliente.id

        #si tiene saldo, se guarda a la bd con estatus 2 (pagada)
        if tiene_saldo
          reserva.estadotipo_id = 2
          reserva.estatus = true
          reserva.referenciapago_id = referenciapago['id']
          reserva.save
        end

        #si no tiene saldo guardar reservaciones en sesión
        if !tiene_saldo
          session[:reservaciones] << viaje_id if !session[:reservaciones].include? viaje_id
        end
      end

    end

      #si tiene saldo, da render a mensaje exitoso
      if tiene_saldo
        session.delete(:reservaciones)
        redirect_to :action=>'viajes', :mensaje => "Compra exitosa"
      end

      #si no tiene saldo, guarda las reservas en la sesión y
      #redirecciona a recargar saldo con mensaje que necesita recargar saldo
      if !tiene_saldo
        redirect_to :action=>'compracredito', :mensaje => "El cargo total es de <b>$#{cantidad_pago}</b>. No tienes saldo suficiente. Recarga y ve al carrito de compras para comprar tu viaje."
      end




  end

  #carrito
  def reservaciones
    @title="Mis Reservas"
    @current_cliente = obtener_cliente(current_user)

    viajes_id = session[:reservaciones]
    if viajes_id
      @viajes = []
      @disponibilidad = []
      viajes_id.each do |viaje_id|
        viaje = Viaje.find(viaje_id)
        @viajes << viaje
        @disponibilidad<<calcula_disponibilidad_viaje(viaje)
      end
    end

    #@cantidad = session[:reservaciones].count

    render 'show_reservaciones'
  end


  def ver_ruta
    @ruta=Ruta.find(params[:id])
    @title = @ruta.nombre
    if signed_in?
      @current_cliente = obtener_cliente(current_user)
    end
    render 'comprar_viajes'
  end


  def enviar_sugerencia
    viaje = Viaje.find(params[:id])
    origen = viaje.ruta.paradas.order('posicion ASC').first
    destino = viaje.ruta.paradas.order('posicion ASC').last
    create_sugerencia(origen, destino, origen.nombre, destino.nombre)

    respond_to do |format|
        format.html {render partial: 'shared/user_sugerencia_enviada', layout:false}
    end
  end



  # =======================================================
  # =======================================================
  # Métodos para las jTables
  # =======================================================
  # =======================================================


  # ///////////////////////////////////////////////////////
  # Método para listar SIN buscar los registros de la BD
  #
  def jtable_list

    jtSorting = params[:jtSorting]
    jtStartIndex = params[:jtStartIndex]
    jtPageSize = params[:jtPageSize]
    jtStartPage = jtStartIndex.to_i / jtPageSize.to_i + 1

    @results = Administrador.order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => Administrador.count,
                      :Records => @results}
      format.json { render json: jTableResult}
      format.html
      format.js
    end
  end

  # ///////////////////////////////////////////////////////
  # Método para BUSCAR y listar los registros de la BD
  #
  def jtable_filterlist
    jtTextoBusqueda = params[:textoABuscar]
    jtAtributoCondicion = params[:atributoCondicion]
    jtCondicion = params[:condicion]
    jtValorCondicion = params[:valorCondicion]
    jtSorting = params[:jtSorting]
    jtStartIndex = params[:jtStartIndex]
    jtPageSize = params[:jtPageSize]
    jtStartPage = jtStartIndex.to_i / jtPageSize.to_i + 1
    @queryFiltrado = ""
    @query = ""

    # Convertimos los valores para que puedan ser procesados por posgresql
    jtSorting = jtSorting.gsub(/(apellidoMaterno)/i, '"apellidoMaterno"')
    jtSorting = jtSorting.gsub(/(apellidoPaterno)/i, '"apellidoPaterno"')
    jtSorting = jtSorting.gsub(/(fechaNacimiento)/i, '"fechaNacimiento"')

    # Si el campo de busqueda tiene solo espacios en blanco.
    if jtTextoBusqueda.blank? || jtTextoBusqueda.to_s == ''
      if jtAtributoCondicion.present? && jtCondicion.present? && jtValorCondicion.present?
        @results = Cliente.joins(:user,:nivel).joins("LEFT OUTER JOIN reservacions ON reservacions.cliente_id = clientes.id")
        .select("count(reservacions.id) as ha_comprado,
                 users.name, \"apellidoPaterno\", \"apellidoMaterno\", \"fechaNacimiento\", users.email,
                 clientes.id as cliente_id, puntaje, emisionco2, kilometros,
                 nivels.nombre as nombre_nivel, nivels.estatus as estatus_nivel, nivels.id as nivel_id")
        .group("users.name, \"apellidoPaterno\", \"apellidoMaterno\", \"fechaNacimiento\", users.email,
                 clientes.id, puntaje, emisionco2, kilometros,
                 nivels.nombre, nivels.estatus, nivels.id")
        .where("#{jtAtributoCondicion} #{jtCondicion} #{jtValorCondicion} AND clientes.estatus = 't'")
        .order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
      else
        @results = Cliente.joins(:user,:nivel).joins("LEFT OUTER JOIN reservacions ON reservacions.cliente_id = clientes.id")
        .select("count(reservacions.id) as ha_comprado,
                 users.name, \"apellidoPaterno\", \"apellidoMaterno\", \"fechaNacimiento\", users.email,
                 clientes.id as cliente_id, puntaje, emisionco2, kilometros,
                 nivels.nombre as nombre_nivel, nivels.estatus as estatus_nivel, nivels.id as nivel_id")
        .group("users.name, \"apellidoPaterno\", \"apellidoMaterno\", \"fechaNacimiento\", users.email,
                 clientes.id, puntaje, emisionco2, kilometros,
                 nivels.nombre, nivels.estatus, nivels.id")
        .where("clientes.estatus = 't'")
        .order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
      end
    else
      if jtAtributoCondicion.present? && jtCondicion.present? && jtValorCondicion.present?
        @queryFiltrado = " AND ( #{jtAtributoCondicion} #{jtCondicion} #{jtValorCondicion} ) "
      end
      @query = "(users.name ILIKE :search OR
                 email ILIKE :search OR
                 to_char(\"fechaNacimiento\", 'MM/DD/YYYY') ILIKE :search OR
                 nivels.nombre ILIKE :search
                ) #{@queryFiltrado} AND clientes.estatus = 't'"
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = Cliente.joins(:user,:nivel).joins("LEFT OUTER JOIN reservacions ON reservacions.cliente_id = clientes.id")
      .select("count(reservacions.id) as ha_comprado,
                 users.name, \"apellidoPaterno\", \"apellidoMaterno\", \"fechaNacimiento\", users.email,
                 clientes.id as cliente_id, puntaje, emisionco2, kilometros,
                 nivels.nombre as nombre_nivel, nivels.estatus as estatus_nivel, nivels.id as nivel_id")
      .group("users.name, \"apellidoPaterno\", \"apellidoMaterno\", \"fechaNacimiento\", users.email,
                 clientes.id, puntaje, emisionco2, kilometros,
                 nivels.nombre, nivels.estatus, nivels.id")
      .where(@query,search: "%#{jtTextoBusqueda.strip}%")
      .order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    end
    # if jtSorting == "ha_comprado ASC"
    #   Hash[@results.sort_by{|c| c[:ha_comprado]}]
    # end
    # if jtSorting == "ha_comprado DESC"
    #   Hash[@results.sort_by{|c| c[:ha_comprado]}.reverse]
    # end
    # clientes_con_reserva =  Reservacion.uniq.pluck(:cliente_id)
    # @results.each { |c|
    #   c[:ha_comprado] = "No"
    #   if clientes_con_reserva.include? c[:id]
    #     c[:ha_comprado] = "Si"
    #   end
    # }
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => @results.count,
                      :Records => @results
      }
      format.json { render json: jTableResult}
      # format.html
      # format.js
    end
  end

  # ///////////////////////////////////////////////////////
  # Método para eliminar registro de la BD
  #
  def jtable_delete
    cliente = Cliente.find(params[:cliente_id])

    # Iniciamos la eliminación del registro, si no se elimina, almacenamos el resultado en un boleano.
    bolExito = true
    errMensaje = ''
    begin
      cliente.estatus= false
      cliente.save!
    rescue => e
      bolExito = false
      errMensaje = "No se pudo eliminar. Revise el error: #{e}"
    end
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      if bolExito
        jTableResult = {:Result => "OK"}
      else
        jTableResult = {:Result => "Message",
                        :Message => errMensaje}
      end
      format.json { render json: jTableResult}
      format.html
      format.js
    end
  end

  private
  end




