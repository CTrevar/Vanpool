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
    	reservacion.cliente.co2=autoco2-vanco2
    	reservacion.save
	end

end