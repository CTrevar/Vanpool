module MedallasHelper

	##MEDALLAS
    #Validar si el cliente tiene medallas
    def valida_medallas(cliente)
      if cliente.medallas.count==0 
        return false
      end
    end

	#Obtener las ultimas 3 medallas del cliente
    def obtener_ultimas_medallas(cliente)
      return cliente.medallas.order("created_at DESC").last(3)
    end

    #obtener todo las medallas del cliente
    def obtener_muro(cliente)
      return cliente.medallas.order("tipomedalla_id ASC").all
    end
	
end
