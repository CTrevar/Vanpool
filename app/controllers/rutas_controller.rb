class RutasController < ApplicationController
	def index
		@rutas = Ruta.all
	end

	 def new
    @ruta = Ruta.new
    @vans = Van.all
    @paradas_existentes = Parada.all
    @nombres_paradas = []

    @paradas_existentes.each do |parada|
      @nombres_paradas.push(parada.nombre)
    end

    @nombres_paradas.delete(nil)
    @nombres_paradas.delete("")
    @nombres_paradas.uniq!

    @letras = ("A".."Z").to_a
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
        @ruta.van_id = params[:vanId]
        @ruta.zona_id = params[:ruta][:zona_id]
        conductor = Conductor.find_by_user_id(params[:conductorId])
        if conductor
          @ruta.conductor_id = conductor.id
        end
        @ruta.estatus = true

      if @ruta.valid?
        @ruta.save

        #Guardar paradas
        

        10.times do |num|
     
          nombreparada = params[:"nombreParada_#{num}"]
          paradas = Parada.all
          if !nombreparada.blank?
            #Guardar paradas_ruta
            #por cada parada
            
            id_parada = 0

            paradas.each do |parada|
              if parada.nombre == nombreparada
                id_parada = parada.id
              end
            end

            @rutaparada = Rutaparada.new
            if id_parada != 0
              #si ya existe la parada, sólo agrega la referencia a la parada
              @rutaparada.parada_id = id_parada
            else 
              #si no existe parada, crea una nueva
              @parada = Parada.new
              @parada.nombre = nombreparada
              @parada.latitud = params[:"latitudParada_#{num}"]
              @parada.longitud = params[:"longitudParada_#{num}"]
              @parada.save
              #guarda el id de la parada en la tabla de paradas_ruta
              @rutaparada.parada_id = @parada.id
            end

            @rutaparada.ruta_id = @ruta.id
            @rutaparada.posicion  = params[:"posicionParada_#{num}"]
            @rutaparada.tiempo = params[:"tiempoParada_#{num}"]
            @rutaparada.distancia = params[:"distanciaParada_#{num}"]
            @rutaparada.save
          end #si hay parada

        end #end for paradas


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
        
        genera_viajes_ruta_nueva(@ruta)

        redirect_to rutas_path
      else
        params[:nombreRuta]
        render 'new'
      end #end if ruta is valid
      
      
  end #end create

	def show
		@ruta = Ruta.find(params[:id])
    @van = @ruta.van
    @conductor = Conductor.find(@ruta.conductor_id)
    @conductorUser = User.find(@conductor.user_id)
    @rel = Rutaparada.where(:ruta_id => @ruta.id)
    @rel.sort! { |a, b| a.posicion <=> b.posicion }
    @paradas_ruta = []
    @rel.each do |p|
      @parada= Parada.find(p.parada_id)
      @paradas_ruta.push(@parada)
    end
    @letras = ("A".."Z").to_a
    #@paradas_ruta = @ruta.paradas
    @paradas_ruta_json = @paradas_ruta.to_json
    
	end

  def detalle
    # @ruta = Ruta.find(params[:id])
    # @paradas_ruta = @ruta.paradas
    # @van = @ruta.van
    @ruta = Ruta.find(params[:id])
    @van = @ruta.van
    @conductor = Conductor.find(@ruta.conductor_id)
    @conductorUser = User.find(@conductor.user_id)
    @rel = Rutaparada.where(:ruta_id => @ruta.id)
    @rel.sort! { |a, b| a.posicion <=> b.posicion }
    @paradas_ruta = []
    @rel.each do |p|
      @parada= Parada.find(p.parada_id)
      @paradas_ruta.push(@parada)
    end
  end

  def actualizar
    @ruta = Ruta.find(params[:id])
      #Guardar ruta
        
        @ruta.nombre = params[:nombreRuta]
        @ruta.precio = params[:precio]
        @ruta.van_id = params[:vanId]
        @ruta.zona_id = params[:ruta][:zona_id]
        conductor = Conductor.find_by_user_id(params[:conductorId])
        @ruta.conductor_id = 1

      if @ruta.valid?
        @ruta.save

        #Guardar paradas
      
        10.times do |num|
          #id_parada = params[:"idParada_#{num}"].to_i

     

          #Guardar paradas_ruta
          #por cada parada
          

          nombreparada = params[:"nombreParada_#{num}"]
          paradas = Parada.all
          if !nombreparada.blank?
            @rutaparada = Rutaparada.find_by_ruta_id_and_posicion(@ruta.id, num)
            @parada = Parada.find(@rutaparada.parada_id)
            if nombreparada != parada.nombre
              @parada_nueva = Parada.new
              @parada_nueva.nombre = params[:"nombreParada_#{num}"]
              @parada_nueva.latitud = params[:"latitudParada_#{num}"]
              @parada_nueva.longitud = params[:"longitudParada_#{num}"]
              @parada_nueva.save
              @rutaparada.parada_id = @parada_nueva.id
            end
          end

          @rutaparada.posicion  = params[:"posicionParada_#{num}"]
          @rutaparada.tiempo = params[:"tiempoParada_#{num}"]
          @rutaparada.distancia = params[:"distanciaParada_#{num}"]
          @rutaparada.save

        end #end for paradas
        
        


        #Guardar frecuencias de la ruta
        @frecuencia = Frecuencia.find_by_ruta_id(@ruta.id)
        @frecuencia.lunes = params[:lunes]
        @frecuencia.martes = params[:martes]
        @frecuencia.miercoles = params[:miercoles]
        @frecuencia.jueves = params[:jueves]
        @frecuencia.viernes = params[:viernes]
        @frecuencia.sabado = params[:sabado]
        @frecuencia.domingo = params[:domingo]
        @frecuencia.save

        

        #Guardar horario
        @horario = Horario.find_by_ruta_id(@ruta.id)
        @horario.hora = params[:horarioRuta]
        @horario.save
        
        #genera_viajes_ruta_nueva(@ruta)

        redirect_to rutas_path
      else
        render 'show'
      end #end if ruta is valid

  end
  def edit
@ruta = Ruta.find(params[:id])
@paradas_ruta = @ruta.paradas
@van = @ruta.van
end

  def listar_por_zona
    filtro_zona_id = params[:zona_id]
    filtro_fecha = params[:filtro_fecha]

    if filtro_zona_id.blank?
      rutas = Ruta.select("id").all
    else
      rutas = Ruta.select("id").where("zona_id = ?", filtro_zona_id)
    end
    viajes = Viaje.where("ruta_id IN (?) AND (estadoviaje_id = 2 or estadoviaje_id = 1)", rutas)
    @result = []
    ahora = Time.now.beginning_of_day
    fecha_inicial = ahora

    if filtro_fecha.downcase.eql? "hoy"
      fecha_final = Time.now.end_of_day
    elsif filtro_fecha.downcase.eql? "esta semana"
      fecha_final = (ahora + 1.week).end_of_day
    elsif filtro_fecha.downcase.eql? "proxima semana"
      fecha_inicial = (ahora +1.week).beginning_of_day
      fecha_final = (fecha_inicial + 1.week).end_of_day
    elsif filtro_fecha.downcase.eql? "este mes"
      fecha_final = (ahora + 1.month).end_of_day
    end
      
    
    viajes.each do |viaje|
      
      fecha_viaje = viaje.fecha.to_time

      #si está entre 2 fechas, se agrega al arreglo de viajes por zona encontrados
      if fecha_viaje <= fecha_final and fecha_viaje >= fecha_inicial
           @result << viaje
      end
    end

    

    respond_to do |format|
        #Enviar viajes resultantes
        format.html { render partial: 'shared/user_rutas_zona', locals: { result: @result}, layout:false}
        
    end
      
  end

  #
  # Metodo para desplegar la información de ruta en un div lateral.
  #
  def administrador_detalleruta
    ruta_id = params[:ruta_id]
    @ruta = Ruta.new
    @ruta = Ruta.find(ruta_id)

    @tiempo = 0
    @distancia = 0

    ##PARADAS!!
    @rel = Rutaparada.where(:ruta_id => @ruta.id)
    @rel.sort! { |a, b| a.posicion <=> b.posicion }
    @paradas_ruta = []
    @rel.each do |p|
      @parada= Parada.find(p.parada_id)
      @paradas_ruta.push(@parada)
      @tiempo += p.tiempo
      @distancia += p.distancia
    end
    #@paradas_ruta = @ruta.paradas
    

    

    # @ruta.paradas.each { |parada|
    #   @tiempo += parada.tiempo
    #   @distancia += parada.distancia
    # }

    @tiempo = @tiempo/60
    @tiempo = (@tiempo*100).round / 100.0
    @distancia = @distancia/1000
    @distancia = (@distancia*100).round / 100.0
      
      # @action = 'update'
      # respond_to do |format|
      #   #format.html {render layout:false}
      #   format.html { render partial: 'shared/administrador_detalleruta', locals: { ruta: @ruta, action: @action }, layout:false}
        
      # end
    #if ruta_id.nil?
      #@action = 'create'
    #else
      #@ruta = Ruta.find(ruta_id)
      #@ruta.paradas.sort! { |a, b| a.posicion <=> b.posicion }
      
      #@action = 'update'
      respond_to do |format|
        #format.html {render layout:false}
        format.html { render partial: 'shared/administrador_detalleruta', locals: { ruta: @ruta, tiempo: @tiempo, distancia: @distancia, paradas_ruta: @paradas_ruta }, layout:false}
        
      end
    #end
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
      @results = Ruta.joins(:van).select(" rutas.id as ruta_id, *").where("rutas.estatus = 't'").order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    else
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = Ruta.joins(:van).select(" rutas.id as ruta_id,  *").where( "rutas.estatus = 't' AND LOWER(nombre) LIKE '%#{jtTextoBusqueda.downcase}%'"
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


  # ///////////////////////////////////////////////////////
  # Método para eliminar registro de la BD
  #
  def jtable_delete
    ruta = Ruta.find(params[:ruta_id])

    # Iniciamos la eliminación del registro, si no se elimina, almacenamos el resultado en un boleano.
    bolExito = true
    errMensaje = ''
    begin
      ruta.estatus = false
      ruta.save!
      count = 0
      usuarios = ""
      viajes = Viaje.where("ruta_id = ? and estadoviaje_id = 2", ruta.id)
      viajes.each do |viaje|
        viaje.estadoviaje_id = 4
        viaje.estatus = 0
        viaje.save!
        reservaciones = Reservacion.where("viaje_id = ?", viaje.id)
        reservaciones.each do |reservacion|
          reservacion.estadotipo_id= 4
          reservacion.estatus = false
          count+=1
          usuarios.concat("  #{reservacion.cliente.user.name}")
          reservacion.save!
        end
      end
    rescue => e
      bolExito = false
      errMensaje = "No se pudo eliminar. Revise el error: #{e}"
    end
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      if bolExito
        jTableResult = {:Result => "OK",
                        :Message => "Se eliminaron #{count} reservaciones de #{usuarios}"}
      else
        jTableResult = {:Result => "Message",
                        :Message => errMensaje}
      end
      format.json { render json: jTableResult}
      format.html
      format.js
    end
  end

  def paradas_jtable_filterlist
    ruta=Ruta.find(params[:id])
    paradas = ruta.paradas.order('posicion ASC')
    tiempoParadas = []

    paradas_viajes = []
    letras = ("A".."Z").to_a
      paradas.each_with_index do |parada, i|
        if i == 0
          tiempoParadas << 0
        elsif i<=paradas.count
          parada_id = parada.id
          tiempo = Rutaparada.find_by_ruta_id_and_parada_id(ruta.id, parada_id).tiempo
          tiempoParadas<< (tiempoParadas[i-1]+tiempo.to_i)        
        end

        parada_viaje = Hash.new
        parada_viaje[:nombre_parada] = parada.nombre.split(",")[0]
        parada_viaje[:letra] = letras[i]
        parada_viaje[:tiempo_parada] = (ruta.horario.hora+tiempoParadas[i]).strftime("%I:%M %p")
        paradas_viajes<<parada_viaje
      end
      
      
          
      @results = paradas_viajes
    
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => paradas.count,
                      :Records => @results
                      }
      format.json { render json: jTableResult}
      format.html
      format.js
    end
  end#paradas_jtable


	private
	#Crea viajes por primera vez de la ruta con las fechas indicadas en la frecuencia semanal por un mes
    def genera_viajes_ruta_nueva(ruta)
      #obtener fecha actual
      hoy = Date.today
      #obtener último día del mes
      dos_meses = hoy + 60
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
        viaje.estatus= 1
        viaje.estadoviaje_id= 2 
        viaje.ruta_id= ruta.id
        viaje.horainicio = horario.hora
        viaje.save
      end


    end

	
	
end
