module ViajesHelper

##Viajes
    #Validar si el cliente tiene medallas
    def valida_viajes(cliente)
      if cliente.reservacions.find_all_by_estadotipo_id(2).count==0 
        return false
      end
    end

    #Validar si el cliente tiene medallas
    def valida_viajes_completos(cliente)
      if cliente.reservacions.find_all_by_estadotipo_id(3).count==0 
        return false
      end
    end

    def existen_viajes
      if(Viaje.find_all_by_estadoviaje_id([3,4]).count>0) 
        return true
      else
        return false
      end
    end

    def existen_reservaciones
      if(Reservacion.find_all_by_estadotipo_id([3,4]).count>0) 
        return true
      else
        return false
      end
    end

end