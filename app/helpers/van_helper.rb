module VanHelper

	def valida_van_llena(van, viaje)
		pasajeros=van.rutas.find(viaje.ruta_id).viajes.find(viaje.id).reservacions.find_all_by_estadotipo_id([2,3]).count
		if(pasajeros<van.capacidad)
			return false
		else
			return true
		end
	end

end
