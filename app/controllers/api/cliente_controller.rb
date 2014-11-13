class API::ClienteController < ApplicationController

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

  	def ruta_disponibilidad_viaje
  	  id=params[:id]
  	  viaje = Viaje.find(id)
      ruta = Ruta.find(viaje.ruta_id)
      van = Van.find(ruta.van_id)
      capacidad = van.capacidad
      pasajeros = viaje.reservacions.find_all_by_estadotipo_id([2,3]).count
      @disponibilidad = capacidad - pasajeros
      	respond_to do |format|
      		format.json { render :json => @disponibilidad }
    	end
    end

    def rutas_busqueda
    	#http://localhost:3000/api/rutas_busqueda?olatitud=25.67093&olongitud=-100.4366063&dlatitud=25.6603322&dlongitud=-100.3689728
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
      	#@medallas = Cliente.find(id).medallas.all(:select=>'medallas.nombre,medallas.descripcion,medallas.imagen', :order=>'medallas.created_at DESC')
      	respond_to do |format|
      		format.json { render :json => @rutas }
    	end
    end


end