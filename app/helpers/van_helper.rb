module VanHelper

	def valida_van_llena(viaje)
		pasajeros=viaje.reservacions.find_all_by_estadotipo_id([2,3]).count
		if(pasajeros==viaje.ruta.van.capacidad)
			return true
		else
			return false
		end
	end

end
