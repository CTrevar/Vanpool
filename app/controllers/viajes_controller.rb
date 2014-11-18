class ViajesController < ApplicationController
 
  def detalle
    @current_cliente = obtener_cliente(current_user)
    @title = params[:id]
    @viaje=Viaje.find(params[:id])
    @disponibilidad = calcula_disponibilidad_viaje(@viaje)
    
    render 'show_detalleviaje'
  end

    # =======================================================
  # =======================================================
  # Métodos para las jTables
  # =======================================================
  # =======================================================


  # ///////////////////////////////////////////////////////
  # Método para BUSCAR y listar los registros de la BD
  #
  def proximos_jtable_filterlist
    jtTextoBusqueda = params[:textoABuscar]
    jtSorting = params[:jtSorting].split(" ")[0]
    jtSortingDirection = params[:jtSorting].split(" ")[1]
    jtStartIndex = params[:jtStartIndex]
    jtPageSize = params[:jtPageSize]
    ruta_id = params[:id]
    jtStartPage = jtStartIndex.to_i / jtPageSize.to_i + 1

    # Si el campo de busqueda tiene solo espacios en blanco.
    if jtTextoBusqueda.blank? || jtTextoBusqueda.to_s == ''
    	@proximos_viajes = []
    	@viajes = Viaje.select("*").where("(estadoviaje_id = 2 or estadoviaje_id = 1) and ruta_id = ?", ruta_id)
    	@viajes.each do |viaje|
    		proximo_viaje = Hash.new
    		proximo_viaje[:viaje_id] = viaje.id
    		proximo_viaje[:fecha] = viaje.fecha.strftime("%d, %b %y")
    		proximo_viaje[:fecha_sinformato] = viaje.fecha
    		proximo_viaje[:conductor] = viaje.ruta.conductor.user.name
    		proximo_viaje[:hora_salida] = viaje.horainicio.strftime("%H:%M")
    		proximo_viaje[:hora_llegada] = (viaje.horainicio+ viaje.ruta.paradas.sum(:tiempo).to_i).strftime("%H:%M")
    		proximo_viaje[:disponibilidad] = calcula_disponibilidad_viaje(viaje)
    		@proximos_viajes<<proximo_viaje
    	end
    			if jtSorting == "fecha"
    				@proximos_viajes.sort_by! {|proximo_viaje| proximo_viaje[:fecha_sinformato]}
    			else
    	    		@proximos_viajes.sort_by! { |proximo_viaje| proximo_viaje[:"#{jtSorting}"] }
    	    	end
    	    	@proximos_viajes.reverse! if jtSortingDirection == 'DESC'
      @results = @proximos_viajes.paginate(page:jtStartPage,per_page:jtPageSize)
    else
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = @proximos_viajes.where( " LOWER(fecha) LIKE '%#{jtTextoBusqueda.downcase}%'"
      ).order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    end
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => Viaje.where("(estadoviaje_id = 2 or estadoviaje_id = 1) and ruta_id = ?", ruta_id).count,
                      :Records => @results
                      }
      format.json { render json: jTableResult}
      format.html
      format.js
    end
  end#proximos_jtable

  def realizados_jtable_filterlist
    jtTextoBusqueda = params[:textoABuscar]
    jtSorting = params[:jtSorting].split(" ")[0]
    jtSortingDirection = params[:jtSorting].split(" ")[1]
    jtStartIndex = params[:jtStartIndex]
    jtPageSize = params[:jtPageSize]
    ruta_id = params[:id]
    jtStartPage = jtStartIndex.to_i / jtPageSize.to_i + 1

    # Si el campo de busqueda tiene solo espacios en blanco.
    if jtTextoBusqueda.blank? || jtTextoBusqueda.to_s == ''
    	@realizados_viajes = []
    	@viajes = Viaje.select("*").where("estadoviaje_id = 3 and ruta_id = ?", ruta_id)
    	@viajes.each do |viaje|
    		realizado_viaje = Hash.new
    		realizado_viaje[:viaje_id] = viaje.id
    		realizado_viaje[:fecha] = viaje.fecha.strftime("%d, %b %y")
    		realizado_viaje[:fecha_sinformato] = viaje.fecha
    		realizado_viaje[:conductor] = viaje.ruta.conductor.user.name
    		realizado_viaje[:hora_salida] = viaje.horainicio.strftime("%H:%M")
    		realizado_viaje[:hora_llegada] = (viaje.horainicio+ viaje.ruta.paradas.sum(:tiempo).to_i).strftime("%H:%M")
    		realizado_viaje[:origen] = viaje.ruta.paradas.order('posicion ASC').first.nombre
    		realizado_viaje[:destino] = viaje.ruta.paradas.order('posicion ASC').last.nombre
    		realizado_viaje[:disponibilidad] = calcula_disponibilidad_viaje(viaje)
    		@realizados_viajes<<realizado_viaje
    	end

    			if jtSorting == "fecha"
    				@realizados_viajes.sort_by! {|realizado_viaje| realizado_viaje[:fecha_sinformato]}
    			else
    	    		@realizados_viajes.sort_by! { |realizado_viaje| realizado_viaje[:"#{jtSorting}"] }
    	    	end
    	    	@realizados_viajes.reverse! if jtSortingDirection == 'DESC'
      @results = @realizados_viajes.paginate(page:jtStartPage,per_page:jtPageSize)
    else
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = @realizados_viajes.where( " LOWER(fecha) LIKE '%#{jtTextoBusqueda.downcase}%'"
      ).order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    end
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => Viaje.where("estadoviaje_id = 3 and ruta_id = ?", ruta_id).count,
                      :Records => @results
                      }
      format.json { render json: jTableResult}
      format.html
      format.js
    end
  end#realizados_jtable


    def paradas_jtable_filterlist
    viaje=Viaje.find(params[:id])
    paradas = viaje.ruta.paradas.order('posicion ASC')
    tiempoParadas = []
    ruta_id = viaje.ruta.id
    paradas_viajes = []
    letras = ("A".."Z").to_a
      paradas.each_with_index do |parada, i|
        if i == 0
          tiempoParadas << 0
        elsif i<=paradas.count
          parada_id = parada.id
          tiempo = Rutaparada.find_by_ruta_id_and_parada_id(ruta_id, parada_id).tiempo
          tiempoParadas<< (tiempoParadas[i-1]+tiempo.to_i)        
        end

        parada_viaje = Hash.new
    		parada_viaje[:nombre_parada] = parada.nombre.split(",")[0]
    		parada_viaje[:letra] = letras[i]
    		parada_viaje[:tiempo_parada] = (viaje.horainicio+tiempoParadas[i]).strftime("%I:%M %p")
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

end
