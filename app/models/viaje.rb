class Viaje < ActiveRecord::Base
  belongs_to :ruta
  attr_accessible :estadoviaje_id, :estatus, :fecha, :horainicio, :ruta_id
  
  has_many :reservacions

  #Crea viajes por primera vez de la ruta con las fechas indicadas en la frecuencia semanal por un mes
	def self.generar_viajes_mensuales
	    #obtener fecha actual
	    hoy = Date.today
	    #obtener último día del mes
	    dos_meses = hoy + 30

	    rutas = Ruta.where("estatus = 't'")

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
	        fechas_viaje = (hoy..dos_meses).to_a.select{
	          |d| dias_ruta.include?(d.wday)
	        }

	        #por cada fecha obtenida, crear un viaje nuevo con la fecha indicada
	        horario = Horario.find_by_ruta_id(ruta.id)
	        fechas_viaje.each do |fecha_viaje| 
	          viaje = Viaje.new
	          viaje.fecha = fecha_viaje 
	          viaje.estatus= true
	          viaje.estadoviaje_id= 2 
	          viaje.ruta_id= ruta.id
	          viaje.horainicio = horario.hora
	          viaje.save
	        end
	    end #for each rutas
	    
	end
end
