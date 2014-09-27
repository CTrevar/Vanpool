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

    #Aumentar puntos al cliente
    def aumenta_puntos(cliente,puntos)
    cliente.puntaje=cliente.puntaje+puntos
    cliente.save
	end

end