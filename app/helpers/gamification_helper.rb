module GamificationHelper

#Obtener las ultimas 3 medallas del cliente
    def obtener_ultimas_medallas(cliente)
      return cliente.medallas.order("created_at DESC").last(3)
    end

    #obtener todo las medallas del cliente
    def obtener_muro(cliente)
      return cliente.medallas.order("created_at ASC").all
    end

    ##NIVELES
    #Validar si el cliente esta en el último nivel del cliente
    def valida_ultimo_nivel(cliente)
      if cliente.nivel.id==Nivel.last.id 
        return true
      else
        return false
      end
    end

    #Obtener mensaje para el siguiente nivel del cliente
    def obtener_mensaje_nivel(cliente)
      if valida_ultimo_nivel(cliente)==false then
        return "Solo te faltan #{calcula_puntos_siguiente_nivel(cliente)} 
        para el nivel #{calcula_siguiente_nivel(cliente).nombre}" 
      end
    end

    #Calcula el siguiente nivel del cliente
    def calcula_siguiente_nivel(cliente)
        return Nivel.find(cliente.nivel.id+1)
    end
    
    #Calcula los puntos necesarios para el siguiente nivel del cliente
    def calcula_puntos_siguiente_nivel(cliente)
      return calcula_siguiente_nivel(cliente).rangomaximo-cliente.puntaje
    end

    ##MEDALLAS
    #Validar si el cliente tiene medallas
    def valida_medallas(cliente)
      if cliente.medallas.count==0 
        return false
      end
    end

    
end