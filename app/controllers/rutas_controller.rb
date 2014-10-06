class RutasController < ApplicationController
	def index
		@rutas = Ruta.all
	end

	def new
		@ruta = Ruta.new
    @vans = Van.all
		@ruta.viajes.build
		@ruta.paradas.build
		@ruta.build_van
		@ruta.build_frecuencia
	end

	def create
    respond_to do |format|
   format.js
 end
		@ruta = Ruta.new(params[:ruta])
		@ruta.estatus = true

		
		@viajes = @ruta.viajes

		@viajes.each do|viaje|
		  viaje.estadoviaje_id=1
		  viaje.estatus = true
		end

		@paradas = @ruta.paradas

		@paradas.each do |parada|
		  parada.estatus = true
		end

		

		# @van = Van.find(:van.attributes['id'])
		# @van.ruta_id = @ruta.attributes['id']
		# @van.update_attributes(params[:van])


		@ruta.save
		genera_viajes_ruta_nueva(@ruta)
		#@viaje.save

		redirect_to rutas_path
	end

	def show
		@ruta = Ruta.find(params[:id])
    @paradas_ruta = @ruta.paradas
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


	private
	#Crea viajes por primera vez de la ruta con las fechas indicadas en la frecuencia semanal por un mes
    def genera_viajes_ruta_nueva(ruta)
      #obtener fecha actual
      hoy = Date.today
      #obtener último día del mes
      un_mes = hoy.end_of_month
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


    end #genera viajes ruta nueva



	
	
end
