module RutasHelper

	def rutas
		return Ruta.all
	end

	def calcular_distancia(reservacion)
		return (reservacion.viaje.ruta.paradas.sum(:distancia)).to_f/1000
	end

	def busqueda (origen, destino)
		result=Array.new
		count=0

		cercaorigen=proximidad(origen)
		cercadestino=proximidad(destino)

		if(cercadestino !=nil or cercaorigen !=nil)
			rutas=buscarutas(cercaorigen, cercadestino)
			
			if(!rutas.blank?)

				rutas.each do |ruta|
					if ruta.estatus = 't'
						paradaorigen=paradacercana(ruta,origen)
						paradadestino=paradacercana(ruta,destino)
						

						if(valida_direccion(paradaorigen,paradadestino,ruta))
							#validacion de ruta
								result<<ruta
						end #if validadireccion
					end #rutatrue

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

