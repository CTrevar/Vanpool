module LidersHelper

	##Lideres
    #Validar si el cliente tiene medallas
    def valida_lider(cliente)
      if cliente.liders.count==0 
        return false
      end
    end

    #obtener todo las medallas del cliente
    def obtener_lider(cliente)
      return cliente.liders.where(:estatus=>true).all
    end
	
end