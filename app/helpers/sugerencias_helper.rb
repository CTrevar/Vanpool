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

	def puntos_cercanos_sugerencia (punto)
		r=Configuracion.find(3).valor.to_d
		puntos = Sugerenciaparada.near([punto.latitud, punto.longitud], r, :units => :km, :order => :distance)
		return puntos
	end

	def incidencias_sugerencias
		#result=[]
		count=0
		sugerencias = Sugerencia.all
		numero_incidencias = []
		coincidencias = []

		sugerencias.each_with_index do |sugerencia, index|
			coincidencia = Hash.new
			coincidencia[:id] = sugerencia.id
				sugerenciaparadas = Sugerenciaparada.where("sugerencia_id= ?",sugerencia.id)
				cercaorigen=puntos_cercanos_sugerencia(sugerenciaparadas.find_by_posicion(0))
				cercadestino=puntos_cercanos_sugerencia(sugerenciaparadas.find_by_posicion(1))
				numero_incidencias[index] = 0
				sugerencias_cercanas = []

				if(cercadestino !=nil or cercaorigen !=nil)
					cercaorigen.each do |origen|
						if origen.posicion == 0 and origen.sugerencia_id!=sugerencia.id
							cercadestino.each do |destino|
								if destino.posicion == 1 and origen.sugerencia_id == destino.sugerencia_id
									sugerencias_cercanas<< origen.sugerencia_id
									#result<<coincidencia
									numero_incidencias[index] += 1
								end
							end
						end
					end
				end

				coincidencia[:sugerencia] = sugerencia
				coincidencia[:sugerencias_cercanas] = sugerencias_cercanas
				coincidencia[:numero_incidencias] = numero_incidencias[index]
				coincidencias<< coincidencia
		end
		
		return coincidencias

	end#incidencias

	def valida_direccion (origen, destino, ruta)
		valida = false
		posicion_o=Sugerenciaparada.find_by_ruta_id_and_parada_id(ruta.id,origen.id).posicion
		posicion_d=Sugerenciaparada.find_by_ruta_id_and_parada_id(ruta.id,destino.id).posicion
		if(posicion_o<posicion_d)
			return true
		else
			return false
		end

		

	end

end
