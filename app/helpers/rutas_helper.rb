module RutasHelper

	def rutas
		return Ruta.all
	end

	def calcular_distancia(reservacion)
		return (reservacion.viaje.ruta.paradas.sum(:distancia))/1000
	end

	def busqueda (origen, destino, fechaviaje)
		result=Array.new
		count=0
		# origen=Localizacion.new
		# #origen.longitud=-100.3857256
		# #origen.latitud=25.6553285
		# origen.longitud=-100.51224869999999
		# origen.latitud=25.7055795

		# destino=Localizacion.new
		# #destino.longitud=-100.41445799999997
		# #destino.latitud=25.6631166
		# destino.longitud=-100.50140679999998
		# destino.latitud=25.6896305

		cercaorigen=proximidad(origen)
		cercadestino=proximidad(destino)

		if(cercadestino !=nil or cercaorigen !=nil)
			rutas=buscarutas(cercaorigen, cercadestino)
			
			if(!rutas.blank?)

				rutas.each do |ruta|
					
					paradaorigen=paradacercana(ruta,origen)
					paradadestino=paradacercana(ruta,destino)
					
					if(valida_direccion(paradaorigen,paradadestino,ruta))
						#validacion de fecha
						
						#fecha="27/09/2014"
						fecha = fechaviaje.to_datetime
						#porfecha=ruta.viajes.find_all_by_fecha_and_estadoviaje_id(fecha,[1,2])

						#fecha= fechaviaje.to_datetime
						fechafin = fecha.end_of_day
						porfecha = ruta.viajes.where("fecha >= ? and fecha <= ?", fecha, fechafin)

						porfecha.each do |v|
							result<<v
						end #porfechaeach
					end #if validadireccion

				end #rutaseach
			end # if rutas not nil
		end #if cercadestino not nil or cercaorigen not nil

		return result
	end

	def proximidad (origen)
		r=Configuracion.find(3).valor.to_d
		p=Array.new
		puntos = Parada.near([origen.latitud, origen.longitud], r, :units => :km, :order => :distance)
		puntos.each do|punto|
			p<<punto.id
		end
		return p
	end

	#recibe Paradas
	def buscarutas (co,cd)
		rutas=Array.new
		rutasc=Ruta.joins(:paradas).where('paradas.id'=>co).uniq
		rutaso=Ruta.joins(:paradas).where('paradas.id'=>cd).uniq
		rutasc.each do |o|
			rutaso.each do |d|
					if(o.id==d.id)
						rutas<<o
					end
				end
			end
		return rutas
	end

	def paradacercana (ruta, punto)
		r=Configuracion.find(3).valor.to_d
		#r = 5.to_d
		return ruta.paradas.near([punto.latitud, punto.longitud], r, :units => :km, :order => :distance).first
	end

	def valida_direccion (origen, destino, ruta)
		valida = false
		posicion_o=Rutaparada.find_by_ruta_id_and_parada_id(ruta.id,origen.id).posicion
		posicion_d=Rutaparada.find_by_ruta_id_and_parada_id(ruta.id,destino.id).posicion
		if(posicion_o<posicion_d)
			return true
		else
			return false
		end

		

	end

	def ordenar_ruta (ruta)
		return Ruta.find(ruta.id).paradas.order("posicion ASC")
	end

end

