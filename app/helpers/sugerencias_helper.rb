module SugerenciasHelper

	def create_sugerencia (origen, destino, horainicio, origenDireccion, destinoDireccion)
		sugerencia = Sugerencia.new
		sugerencia.hora_inicio = Time.parse(horainicio)
		
		if sugerencia.valid?
			
			sugerencia.save

			sugerenciaorigen = Sugerenciaparada.new
			sugerenciaorigen.latitud = origen.latitud
			sugerenciaorigen.longitud = origen.longitud
			sugerenciaorigen.sugerencia_id = sugerencia.id
			sugerenciaorigen.posicion = 0
			sugerenciaorigen.nombre = origenDireccion

			if sugerenciaorigen.valid?
				sugerenciaorigen.save
			end

			sugerenciadestino = Sugerenciaparada.new
			sugerenciadestino.latitud = destino.latitud
			sugerenciadestino.longitud = destino.longitud
			sugerenciadestino.sugerencia_id = sugerencia.id
			sugerenciadestino.posicion = 1
			sugerenciadestino.nombre = destinoDireccion

			if sugerenciadestino.valid?
				sugerenciadestino.save
			end
		
		end #sugerencia valida

		

	end

end
