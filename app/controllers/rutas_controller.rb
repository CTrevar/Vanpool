class RutasController < ApplicationController
	def index
		@rutas = Ruta.all
	end

	def new
		@ruta = Ruta.new
    @vans = Van.all
    #@ruta.viajes.build
    8.times do
      @ruta.paradas.build
    end

    #@ruta.paradas.build
    @ruta.build_van
    @ruta.build_frecuencia
	end

	def create
		@ruta = Ruta.new(params[:ruta])
    @ruta.estatus = true

    
    # @viajes = @ruta.viajes

    # @viajes.each do|viaje|
    #   viaje.estadoviaje_id=1
    #   viaje.estatus = true
    # end

    @paradas = @ruta.paradas

    @paradas.each do |parada|
      parada.estatus = true
    end

    

    # @van = Van.find(:van.attributes['id'])
    # @van.ruta_id = @ruta.attributes['id']
    # @van.update_attributes(params[:van])


    @ruta.save
    genera_viajes_ruta_nueva(@ruta)
    

    redirect_to rutas_path
	end

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
      fechas_viaje.each do |fecha_viaje| 
        viaje = Viaje.new
        viaje.fecha = fecha_viaje 
        viaje.estatus= 1
        viaje.estadoviaje_id= 1 
        viaje.ruta_id= ruta.id
        viaje.horainicio = ruta.hora_inicio
        viaje.save
      end


    end

	
	
end
