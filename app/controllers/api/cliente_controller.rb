class API::ClienteController < ApplicationController

  #http_basic_authenticate_with name: 'admin', password: 'secret'
  #respond_to :json

  #before_filter :authenticate_user! 

  ##registrar usuario
  #curl -H "Content-Type: application/json" -d '{"user":{"name":"sergios","email":"sergios@purpledunes.com","password":"12345678"}}' -X POST http://localhost:3000/api/signup

  ##login de usuario
  ##curl -H 'Content-Type: application/json'   -H 'Accept: application/json' -X POST http://localhost:3000/api/signin   -d '{"user": {"email": "cliente3@gmail.com", "password": "12345678"}}'
  #return {"user":{"admin":false,"apellidoMaterno":null,"apellidoPaterno":null, "authentication_token":"bfTkFLmU0UuXMnVpy/A8+qDeRY5uNtOnSrQ9pdjoWuk=","created_at":"2014-11-19T08:12:35Z","email":"cliente3@gmail.com","estatusUsuario":true,"fechaNacimiento":"1992-07-29T00:00:00Z","id":3,"name":"Marta Jiménez","provider":null,"uid":null,"updated_at":"2014-11-19T20:34:42Z"},"status":"ok","authentication_token":"bfTkFLmU0UuXMnVpy/A8+qDeRY5uNtOnSrQ9pdjoWuk="


  	def cliente_perfil
		id=params[:id]
    	@perfil = Cliente.joins(:user).select('name, puntaje, kilometros, nivel_id').find(id)
    	respond_to do |format|
      		format.json { render :json => @perfil }
    	end
  	end

  	def cliente_medallas
  		id=params[:id]
      	@medallas = Cliente.find(id).medallas.all(:select=>'medallas.nombre,medallas.descripcion,medallas.imagen', :order=>'medallas.created_at DESC')
      	respond_to do |format|
      		format.json { render :json => @medallas }
    	end
    end

    def cliente_muestra_retro
      @aspectos =Retroaspecto.select('nombre, id').find_all_by_estatus(true)
        respond_to do |format|
          format.json { render :json => @aspectos }
      end
    end

    def cliente_envia_retro
    #http://localhost:3000/api/cliente_envia_retro?id=10&retro[]=4&retro[]=5&retro[]=2
    #catchexceptions
        id=params[:id]
        if Reservacion.exists?(id)
          reservacion=Reservacion.find(id)
          if existe_retroalimentacion(reservacion)==false then
            calif=params[:retro]
            x=0
            aspectos.each do |aspecto|
            calificacion=calif[x]
            retro = Retroalimentacion.create(reservacion_id:id,aspecto_id:aspecto.id,tipocalificacion_id:calificacion)
            x=x+1
          end
          @exito=true
          else
          @exito=false
          end
        else
          @exito=false
        end

        respond_to do |format|
          format.json { render :json => @exito }
      end
    end

    def cliente_envia_reporte
      id=params[:id]
      msj=params[:msj]
      if Cliente.exists?(id)
        reportes=Reporte.find_all_by_cliente_id(id)
        if reportes.last.created_at.time+1800<Time.now
          retro = Reporte.create(cliente_id:id,descripcion:msj)
          @exito=true
        else
          @exito=false
        end
      else
        @exito=false
      end

        respond_to do |format|
          format.json { render :json => @exito }
      end
    end

    def cliente_envia_sugerencia
      #horainicio, no sera mejor hora llegada destino
      #http://localhost:3000/api/cliente_envia_sugerencia?olatitud=25.77093&olongitud=-100.4386063&dlatitud=25.6609322&dlongitud=-100.3689028&odire=bosques&ddire=huateca&hora=13:00

      olat=params[:olatitud]
      olong=params[:olongitud]
      origenDireccion=params[:odire]

      dlat=params[:dlatitud]
      dlong=params[:dlongitud]
      destinoDireccion=params[:ddire]

      horainicio=params[:hora]

      origen=Localizacion.new
      origen.longitud=olong
      origen.latitud=olat
    
      destino=Localizacion.new
      destino.longitud=dlong
      destino.latitud=dlat

      create_sugerencia(origen, destino, horainicio, origenDireccion, destinoDireccion)

      @exito=true

      respond_to do |format|
          format.json { render :json => @exito }
      end

    end

    def cliente_leaderboard
    	id=params[:id]
      	#@medallas = Cliente.find(id).medallas.all(:select=>'medallas.nombre,medallas.descripcion,medallas.imagen', :order=>'medallas.created_at DESC')
      	current_cliente=Cliente.joins(:user).select('name, puntaje').find(id)
      	@top=Cliente.joins(:user).select('name, puntaje').order('puntaje DESC').where('puntaje > ?',current_cliente.puntaje).last(2)
        @bot=Cliente.joins(:user).select('name, puntaje').order('puntaje DESC').where('puntaje < ?',current_cliente.puntaje).first(2)

	    if(@top.count==1) 
    		@bot=Cliente.joins(:user).select('name, puntaje').order('puntaje DESC').where('puntaje < ?',current_cliente.puntaje).first(3)
    	end
    	if(@top.count==0)
    		@bot=Cliente.joins(:user).select('name, puntaje').order('puntaje DESC').where('puntaje < ?',current_cliente.puntaje).first(4)
    	end
    	if(@bot.count==1)
      		@top=Cliente.joins(:user).select('name, puntaje').order('puntaje DESC').where('puntaje > ?',current_cliente.puntaje).last(3)
    	end
    	if(@bot.count==0)
      		@top=Cliente.joins(:user).select('name, puntaje').order('puntaje DESC').where('puntaje > ?',current_cliente.puntaje).last(4)
    	end

    	@leaderboard||=Array.new

    	@top.each do |top|
    		@leaderboard.push(top)
    	end
    	
    	@leaderboard.push(current_cliente)

    	@bot.each do |bot|
    		@leaderboard.push(bot)
    	end

      	respond_to do |format|
      		format.json { render :json => @leaderboard }
    	end
    end



  	def rutas_zona 
		id=params[:id]
		if (id!=nil)
    		@rutas = Ruta.find_by_zona_id(id)
    		respond_to do |format|
      			format.json { render :json => @rutas }
    		end
    	else
    		@rutas = Ruta.all
    		respond_to do |format|
      			format.json { render :json => @rutas }
    		end
    	end
  	end

    def rutas_viajes 
    id=params[:id]
    if (id!=nil)
        @rutas = Ruta.find(id)
        @viajes=@rutas.viajes.select('fecha, id,estadoviaje_id')
        respond_to do |format|
            format.json { render :json => @viajes }
        end
      else
        @rutas = Ruta.all
        respond_to do |format|
            format.json { render :json => @rutas }
        end
      end
    end

  	def ruta_disponibilidad_viaje
      begin
  	  id=params[:id]
  	  viaje = Viaje.find(id)
      ruta = Ruta.find(viaje.ruta_id)
      van = Van.find(ruta.van_id)
      capacidad = van.capacidad
      pasajeros = viaje.reservacions.find_all_by_estadotipo_id([2,3]).count
      @disponibilidad = capacidad - pasajeros

      rescue ActiveRecord::RecordNotFound
        @exito="No se encontro el viaje"
      rescue Exception
        @exito="Algo salio mal, vuelva a intentar"
      end
      	respond_to do |format|
      		format.json { render :json => @disponibilidad }
    	end
    end

    def rutas_busqueda
    	#http://localhost:3000/api/rutas_busqueda?olatitud=25.67093&olongitud=-100.4366063&dlatitud=25.6603322&dlongitud=-100.3689728
      #http://localhost:3000/api/rutas_busqueda?olatitud=25.77093&olongitud=-100.4386063&dlatitud=25.6609322&dlongitud=-100.3689028 
  		
      olat=params[:olatitud]
  		olong=params[:olongitud]

  		dlat=params[:dlatitud]
  		dlong=params[:dlongitud]

  		origen=Localizacion.new
		  origen.longitud=olong
		  origen.latitud=olat
		
		  destino=Localizacion.new
		  destino.longitud=dlong
		  destino.latitud=dlat
		
  		@rutas = busqueda(origen,destino)

      if @rutas[0]==nil
        horainicio="00:00"
        origenDireccion=""
        destinoDireccion=""
        create_sugerencia(origen, destino, horainicio, origenDireccion, destinoDireccion)
        @rutas="No se encontro, sugerencia enviada"
        respond_to do |format|
          format.json { render :json => @rutas }
        end
      else
      	respond_to do |format|
      		format.json { render :json => @rutas }
    	end 
    end
    end

    def cliente_co2ahorrado
      begin
      id=params[:id]
      current_cliente=Cliente.find(id)
       co2emitido = current_cliente.emisionco2.to_f
       co2auto =current_cliente.kilometros.to_f*(Configuracion.find(1).valor.to_f/1000)
       @modelo = Configuracion.find(4).valor
       @datos = Array.new
       @datos<<co2auto-co2emitido
       @datos<<@modelo
       rescue ActiveRecord::RecordNotFound
        @exito="No se encontro el cliente"
      rescue Exception
        @exito="Algo salio mal, vuelva a intentar"
      end
       respond_to do |format|
          format.json { render :json => @datos }
      end
    end

    def cliente_co2_viaje
      begin
      id=params[:id]
       reservacion=Reservacion.find(id)
       co2emitido=calcula_co2_viaje(reservacion)
       co2auto=calcular_distancia(reservacion)*(Configuracion.find(1).valor.to_f/1000)
       @co2 = co2auto-co2emitido
       @auto = Configuracion.find(4).valor
       @datos = Array.new
       @datos<<@co2
       @datos<<@auto

      rescue ActiveRecord::RecordNotFound
        @exito="No se encontro la reservacion"
      rescue Exception
        @exito="Algo salio mal, vuelva a intentar"
      end
       respond_to do |format|
          format.json { render :json => @datos }
      end
    end

     def cliente_checkin
      begin 
      id=params[:id]
      if Reservacion.find(id).estadotipo_id==2
        checkin(id)
        @exito=true
      else
        @exito="Ya ha realizado checkin anteriormente"
      end
      rescue ActiveRecord::RecordNotFound
        @exito="No se encontro la reservacion"
      rescue Exception
        @exito="Algo salio mal, vuelva a intentar"
      end
       respond_to do |format|
          format.json { render :json => @exito }
      end
    end

    def cliente_reserva_viajes
      #http://localhost:3000/api/cliente_reserva_viajes?id=1&viaje[]=4&viaje[]=5&viaje[]=2
      begin
      cliente=params[:id]    
      viajes=params[:viaje]
      
      pedido=Array.new
      x=0
      cantidad_pago=0.0
      
      viajes.length.times do
        v=Viaje.find(viajes[x])
        cantidad_pago=cantidad_pago+v.ruta.precio.to_f
        pedido<<v
        x=x+1
      end

      if valida_saldo_suficiente_api(cantidad_pago, cliente)
        referenciapago=compra_api(cantidad_pago, cliente)

        pedido.each do |index|
          reserva = Reservacion.new
          reserva.viaje_id = index.id
          reserva.cliente_id = cliente.to_i
          reserva.referenciapago_id=referenciapago["id"]
          reserva.estadotipo_id=2
          reserva.save
        end
        @exito=true
      else
        @exito="No tiene saldo suficiente"
      end
      rescue OpenpayTransactionException
        @exito= "No se pudo realizar la transaccion"
      rescue ActiveRecord::RecordNotFound
        @exito="Cliente o viaje no encontrado"
      rescue Exception
        @exito="Algo salio mal, vuelva a intentar"
      end
      respond_to do |format|
          format.json { render :json => @exito }
      end

    end
end