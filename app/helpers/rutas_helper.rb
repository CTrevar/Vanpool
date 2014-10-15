module RutasHelper

	def rutas
		return Ruta.all
	end

	def busqueda (origen, destino)
		result=nil
		count=0
		origen=localizacion.new
		origen.x=3
		origen.y=4
		destino=localizacion.new
		destino.x=3
		destino.y=4
		cercaorigen=proximidad(origen)
		cercadestino=proximidad(destino)
		if(cercadestino !=nil or cercaorigen !=nil)
			rutas=buscarutas(cercaorigen, cercadestino)
			if(rutas!=nil)
				rutas.each do |ruta|
					paradaorigen=paradacercana(ruta,origen)
					paradadestino=paradacercana(ruta,destino)
					if(valida_direccion(ruta,paradadestino,paradaorigen))
						result[:"#{count}"]=ruta
					end
				end
			end
		end
		return result
	end

	def proximidad (origen)
		r=Configuracion.find(3).valor.to_d
		#ejemplo
		puntos=Parada.where(:x=>origen.x-r..origen.x+r).where(:y=>origen.y-r..origen.y+r)
		return puntos
	end

	def buscarutas (co,cd)
		rutas=nil
		count = 0
		co.each do |origen|
			cd.each do |destino|
				if(origen.ruta==destino.ruta)
					#revisar que count funcione
					rutas[:"#{count}"] = origen.ruta
					count=count+1
				end
			end
		end
		return rutas
	end

	def paradacercana (ruta, punto)
		paradacercana=nil
		r=Configuracion.find(3).valor.to_d
		diferenciax=r 
		diferenciay=r
		ruta.paradas.each do |parada|
			difx=parada.x-punto.x
			dify=parada.y-punto.y
			if((difx<=r or difx>=-r)and(dify<=r or dify>=-r) and (diferenciax>difx and diferenciay>dify))
				paradacercana=parada
				diferenciax=difx
				diferenciay=dify				
			end
		end
		return paradacercana
	end

	def valida_direccion (origen, destino)
		#solo se usa si es por nodos
		#orden_ruta=ordenar_ruta(ruta)
		#posicion_o=busca_posicion(orden_ruta, origen)
		#posicion_d=busca_posicion(orden_ruta, destino)
		if(origen.posicion<destino.posicion)
			return true
		else
			return false
	end

	def ordenar_ruta (ruta)
		return Ruta.find(ruta.id).order("posicion DESC")
	end

	def busca_posicion (ruta, parada)
		ruta.paradas.each do |parada|
		end
		return posicion
	end

end
end
