module GamificationHelper

	#cambio de nivel
	def cambio_nivel(cliente)
		niveles=Nivel.find_all_by_estatus(true)
		niveles.each do |nivel|
    		if(cliente.puntaje>nivel.rangomaximo && valida_ultimo_nivel(cliente)==false)then
      			cliente.nivel_id=nivel.id+1
    		end
    	end
    	cliente.save
        asigna_medalla_nivel(cliente)
	end

	#Dar medalla tipo viaje
    def asigna_medalla_viaje(cliente)
    	medallas=Medalla.find_all_by_tipomedalla_id_and_estatus(1,true)
    	medallas.each do |medalla|
    		if(cliente.reservacions.find_all_by_estadotipo_id(3).count==medalla.estado) then
      			medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
      			medallamuro.save
      			aumenta_puntos(cliente,medalla.puntos)
    		end
    	end
    end

     #Dar medalla tipo lleno total
    def asigna_medalla_llenototal(cliente)
        medallas=Medalla.find_all_by_tipomedalla_id_and_estatus(4,true)
        reservaciones=Reservacion.find_all_by_cliente_id_and_estadotipo_id(cliente.id,[2,3])
        llenostotales=0

        reservaciones.each do |reservacion|
            if(valida_van_llena(reservacion.viaje.ruta.van, reservacion.viaje))then
                llenostotales=llenostotales+1
            end
        end

        medallas.each do |medalla| 
            if(llenostotales==medalla.estado) then
                medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
                medallamuro.save
                aumenta_puntos(cliente,medalla.puntos)
            end
        end
    end

    def envia_retro
        #retro.save
        #asigna_medalla_retro(cliente)
    end

    #Dar medalla tipo retro
    ##no esta probado
    def asigna_medalla_retro(cliente)
        medallas=Medalla.find_all_by_tipomedalla_id_and_estatus(3,true)
        reservas=Reservacion.find_all_by_cliente_id_and_estadotipo_id(cliente.id,[2,3])
        cuenta=0
        reservas.each do |reserva|
            if(reserva.retroalimentacions.count==1) then
                cuenta=cuenta+1
            end
        end

        medallas.each do |medalla|
            if(cuenta==medalla.estado) then
                medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
                medallamuro.save
                aumenta_puntos(cliente,medalla.puntos)
            end
        end
    end

    def envia_share
        #share.save
        #asigna_medalla_retro(cliente)
    end

    #Dar medalla tipo social
    ##no esta probado
    def asigna_medalla_social(cliente)
        medallas=Medalla.find_all_by_tipomedalla_id_and_estatus(2,true)
        shares=Share.find_all_by_cliente_id(cliente.id) ##cambiarlo por id facebook

        medallas.each do |medalla|
            if(shares.count==medalla.estado) then
                medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
                medallamuro.save
                aumenta_puntos(cliente,medalla.puntos)
            end
        end
    end

    #Dar medalla tipo cumpleaños
    ##no esta probado
    ##como se valida que no haya cambiado la fecha solo para tener la promo
    def asigna_medalla_bday(cliente)
        #medalla=Medalla.find_by_tipomedalla_id_and_estatus(5,true)
        #if(cliente.fechanacimiento==date.now) then
            #medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
            #medallamuro.save
            #aumenta_puntos(cliente,medalla.puntos)
        #end
    end

    #Metodo con facebook
    def obtener_amigos(cliente)
        amigos=["1","2","3"]
        return amigos
    end

    def viaja_con_amigos(cliente,reservacion)
        viaje=reservacion.viaje
        pasajeros=viaje.reservacions
        amigos=obtener_amigos
        amigosenviaje=0

        amigos.each do |amigo|
            pasajeros.each do |pasajero|
                if(pasajero==amigo)then
                    amigosenviaje=amigosenviaje+1
                end
            end
        end
        return amigosenviaje
    end

    #Dar medalla tipo viaja con amigos
    ##no esta probado
    def asigna_medalla_amigos(cliente, reservacion)
        medallas=Medalla.find_all_by_tipomedalla_id_and_estatus(7,true)

        medallas.each do |medalla| 
            if(viaja_con_amigos(cliente,reservacion)>=medalla.estado) then
                medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
                medallamuro.save
                aumenta_puntos(cliente,medalla.puntos)
            end
        end
    end

    #Dar medalla tipo anfitrion
    ##no esta probado
    ##en donde se guarda la cantidad de reservas???
    def asigna_medalla_anfitrion(cliente, reservacion)
        medallas=Medalla.find_all_by_tipomedalla_id_and_estatus(8,true)

        medallas.each do |medalla| 
            #if(reservacion.cantidad==medalla.estado) then
                medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
                medallamuro.save
                aumenta_puntos(cliente,medalla.puntos)
            #end
        end
    end

    #Dar medalla tipo anfitrion
    ##no esta probado
    def asigna_medalla_nivel(cliente)
        medallas=Medalla.find_all_by_tipomedalla_id_and_estatus(9,true)

        medallas.each do |medalla| 
            if(cliente.nivel_id==medalla.estado) then
                medallamuro = Medallasmuro.create(cliente_id:cliente.id,medalla_id:medalla.id)
                medallamuro.save
                aumenta_puntos(cliente,medalla.puntos)
            end
        end
    end
    

    #Aumentar puntos al cliente
    def aumenta_puntos(cliente,puntos)
    cliente.puntaje=cliente.puntaje+puntos
    cliente.save
	end

	#Aumenta kilometraje al cliente
	def aumenta_kilometraje(reservacion)
		reservacion.cliente.kilometraje=reservacion.cliente.kilometraje+reservacion.viaje.ruta.kilometros
		reservacion.cliente.save
	end

    #Si la van va llena se multiplica por dos los puntos del kilometraje
	def aumenta_puntos_kilometraje(reservacion)
		if (valida_van_llena(reservacion.viaje.ruta.van, reservacion.viaje))
			aumenta_puntos(reservacion.cliente,reservacion.viaje.ruta.kilometros*10*2)
		else
			aumenta_puntos(reservacion.cliente,reservacion.viaje.ruta.kilometros*10)
		end
	end


	#Calculo de CO2
	def calcula_co2(reservacion)
    	vanco2=reservacion.viaje.ruta.kilometros*(@reservacion.viaje.ruta.van.co2gxkm/Reservacion.find_all_by_estadotipo_id_and_viaje_id([2,3],@reservacion.viaje_id).count)
    	#autoco2=@reservacion.viaje.ruta.kilometros*Configuracion.find_by_nombre("CO2gxkmauto").valor
    	autoco2=reservacion.viaje.ruta.kilometros*196
    	reservacion.cliente.co2ahorrado=autoco2-vanco2
    	reservacion.cliente.save
	end

end