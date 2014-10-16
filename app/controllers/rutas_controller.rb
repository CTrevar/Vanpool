class RutasController < ApplicationController
	def index
		@rutas = Ruta.all
	end

	 def new
    @ruta = Ruta.new
    @vans = Van.all
    #@ruta.viajes.build
    
    # 8.times do
    #   @ruta.paradas.build
    # end

    ##@ruta.paradas.build
    
    #@ruta.build_van
    #@ruta.build_frecuencia
  end

  def create
    # @ruta = Ruta.new(params[:ruta])
  #   @ruta.estatus = true



  #   @paradas = @ruta.paradas

  #   @paradas.each do |parada|
  #     parada.estatus = true
  #   end




  #   @ruta.save
  #   genera_viajes_ruta_nueva(@ruta)
    

  #   redirect_to rutas_path
      
      #Guardar ruta
      @ruta = Ruta.new
      @ruta.nombre = params[:nombreRuta]
      @ruta.precio = params[:precio]
      @ruta.van_id = params[:idvan]
      @ruta.conductor_id = params[:conductorId]
      @ruta.estatus = true


      @ruta.save

      #Guardar paradas
      numero_paradas = params[:numeroParadas].to_i+1


      numero_paradas.times do |num|
        id_parada = params[:"idParada_#{num}"].to_i

   

        #Guardar paradas_ruta
        #por cada parada
        @rutaparada = Rutaparada.new

        #if id_parada
          #guarda la id de la ruta 
          #@rutaparada.parada_id = id_parada
        #else 
          #si no existe parada, crea una nueva
          @parada = Parada.new
          @parada.nombre = params[:"nombreParada_#{num}"]
          @parada.latitud = params[:"latitudParada_#{num}"]
          @parada.longitud = params[:"longitudParada_#{num}"]
          @parada.save
          #guarda el id de la parada en la tabla de paradas_ruta
          @rutaparada.parada_id = @parada.id
        #end

        @rutaparada.ruta_id = @ruta.id
        @rutaparada.posicion  = params[:"posicionParada_#{num}"]
        @rutaparada.tiempo = params[:"tiempoParada_#{num}"]
        @rutaparada.distancia = params[:"distanciaParada_#{num}"]
        @rutaparada.save

      end #end for
      
      
      
      
      
    


      #Guardar frecuencias de la ruta
      @frecuencia = Frecuencia.new
      @frecuencia.lunes = params[:lunes]
      @frecuencia.martes = params[:martes]
      @frecuencia.miercoles = params[:miercoles]
      @frecuencia.jueves = params[:jueves]
      @frecuencia.viernes = params[:viernes]
      @frecuencia.sabado = params[:sabado]
      @frecuencia.domingo = params[:domingo]
      @frecuencia.ruta_id = @ruta.id
      @frecuencia.save

      

      #Guardar horario
      @horario = Horario.new
      @horario.hora = params[:horarioRuta]
      @horario.ruta_id = @ruta.id
      @horario.save
      
      #genera_viajes_ruta_nueva(@ruta)

      redirect_to rutas_path
  end #end create

	def show
		@ruta = Ruta.find(params[:id])
    @van = @ruta.van
    @paradas_ruta = @ruta.paradas
    @ruta.paradas.sort! { |a, b| a.posicion <=> b.posicion }
	end

  def edit
    @ruta = Ruta.find(params[:id])
    @paradas_ruta = @ruta.paradas
    @van = @ruta.van
  end

  def update
    @ruta = Ruta.find(params[:id])
    if @ruta.update_attributes(params[:ruta])
      redirect_to rutas_path
    else
      render 'edit'
    end
  end

  #
  # Metodo para desplegar la información de ruta en un div lateral.
  #
  def administrador_detalleruta
    ruta_id = params[:ruta_id]
    @ruta = Ruta.new
    @ruta = Ruta.find(ruta_id)

    ##PARADAS!!
      @ruta.paradas.sort! { |a, b| a.posicion <=> b.posicion }
    @tiempo = 0
    @distancia = 0
    @ruta.paradas.each { |parada|
      @tiempo += parada.tiempo
      @distancia += parada.distancia
    }

    @tiempo = @tiempo/60
    @tiempo = (@tiempo*100).round / 100.0
    @distancia = @distancia/1000
    @distancia = (@distancia*100).round / 100.0
      
      # @action = 'update'
      # respond_to do |format|
      #   #format.html {render layout:false}
      #   format.html { render partial: 'shared/administrador_detalleruta', locals: { ruta: @ruta, action: @action }, layout:false}
        
      # end
    if ruta_id.nil?
      @action = 'create'
    else
      @ruta = Ruta.find(ruta_id)
      @ruta.paradas.sort! { |a, b| a.posicion <=> b.posicion }
      
      @action = 'update'
      respond_to do |format|
        #format.html {render layout:false}
        format.html { render partial: 'shared/administrador_detalleruta', locals: { ruta: @ruta, action: @action, tiempo: @tiempo, distancia: @distancia }, layout:false}
        
      end
    end
  end


  # =======================================================
  # =======================================================
  # Métodos para las jTables
  # =======================================================
  # =======================================================


  # ///////////////////////////////////////////////////////
  # Método para listar SIN buscar los registros de la BD
  #
  def jtable_list

    jtSorting = params[:jtSorting]
    jtStartIndex = params[:jtStartIndex]
    jtPageSize = params[:jtPageSize]
    jtStartPage = jtStartIndex.to_i / jtPageSize.to_i + 1

    @results = Ruta.order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => Ruta.count,
                      :Records => @results}
      format.json { render json: jTableResult}
      format.html
      format.js
    end
  end

  # ///////////////////////////////////////////////////////
  # Método para BUSCAR y listar los registros de la BD
  #
  def jtable_filterlist
    jtTextoBusqueda = params[:textoABuscar]
    jtSorting = params[:jtSorting]
    jtStartIndex = params[:jtStartIndex]
    jtPageSize = params[:jtPageSize]
    jtStartPage = jtStartIndex.to_i / jtPageSize.to_i + 1

    # Si el campo de busqueda tiene solo espacios en blanco.
    if jtTextoBusqueda.blank? || jtTextoBusqueda.to_s == ''
      @results = Ruta.joins(:van).select(" rutas.id as ruta_id, *").order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    else
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = Ruta.joins(:van).select(" rutas.id as ruta_id, *").where( "LOWER(nombre) LIKE '%#{jtTextoBusqueda.downcase}%'"
      ).order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    end
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => Ruta.joins(:van).count,
                      :Records => @results
                      }
      format.json { render json: jTableResult}
      format.html
      format.js
    end
  end


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
      horario = Horario.find_by_ruta_id(ruta.id)
      fechas_viaje.each do |fecha_viaje| 
        viaje = Viaje.new
        viaje.fecha = fecha_viaje 
        viaje.estatus= 1
        viaje.estadoviaje_id= 1 
        viaje.ruta_id= ruta.id
        viaje.horainicio = horario.hora
        viaje.save
      end


    end

	
	
end
