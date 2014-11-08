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

    def calcula_disponibilidad_viaje(viaje)
      ruta = Ruta.find(viaje.ruta_id)
      van = Van.find(ruta.van_id)
      capacidad = van.capacidad
      pasajeros = viaje.reservacions.find_all_by_estadotipo_id([2,3]).count
      return capacidad - pasajeros
    end

    def calcula_pasajeros_viaje(viaje)
      ruta = Ruta.find(viaje.ruta_id)
      pasajeros = viaje.reservacions.find_all_by_estadotipo_id([2,3]).count
      return pasajeros
    end

    #Crea viajes por primera vez de la rutas con las fechas indicadas en la frecuencia semanal cada primero de mes
    def genera_viajes_mensuales()
      #obtener fecha actual
      hoy = Date.today
      #obtener último día del mes
      un_mes = hoy.end_of_month
      #obtener todas las rutas
      rutas = Ruta.all


      rutas.each do |ruta|

          #obtener frecuencia semanal de la ruta
          frecuencia = ruta.frecuencia

          #hacer un arreglo con los días que la ruta pasa
          dias_ruta = []

          if frecuencia.lunes
            dias_ruta.push(1)
          end
          if frecuencia.martes
            dias_ruta.push(2)
          end
          if frecuencia.miercoles
            dias_ruta.push(3)
          end
          if frecuencia.jueves
            dias_ruta.push(4)
          end
          if frecuencia.viernes
            dias_ruta.push(5)
          end
          if frecuencia.sabado
            dias_ruta.push(6)
          end
          if frecuencia.domingo
            dias_ruta.push(0)
          end

          #crear un arreglo con las fechas del mes correspondientes a los días de la semana en que pasa la ruta
          fechas_viaje = (hoy..un_mes).to_a.select{
            |d| dias_ruta.include?(d.wday)
          }

          #por cada fecha obtenida, crear un viaje nuevo con la fecha indicada
          fechas_viaje.each do |fecha_viaje| 
            viaje = Viaje.new
            viaje.fecha = fecha_viaje 
            viaje.estatus= 1
            viaje.estadoviaje_id= 1 
            viaje.ruta_id= ruta.id
            viaje.save
          end

      end #each ruta


    end #genera_viajes


end