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
  # Método para listar SIN buscar los registros de la BD
  #
  def jtable_list

    jtSorting = params[:jtSorting]
    jtStartIndex = params[:jtStartIndex]
    jtPageSize = params[:jtPageSize]
    jtStartPage = jtStartIndex.to_i / jtPageSize.to_i + 1

    @results = Viaje.order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => Viaje.count,
                      :Records => @results}
      format.json { render json: jTableResult}
      format.html
      format.js
    end
  end

  # ///////////////////////////////////////////////////////
  # Método para BUSCAR y listar los registros de la BD
  #
  def proximos_jtable_filterlist
    jtTextoBusqueda = params[:textoABuscar]
    jtSorting = params[:jtSorting].split(" ")[0]
    jtSortingDirection = params[:jtSorting].split(" ")[1]
    jtStartIndex = params[:jtStartIndex]
    jtPageSize = params[:jtPageSize]
    jtStartPage = jtStartIndex.to_i / jtPageSize.to_i + 1

    # Si el campo de busqueda tiene solo espacios en blanco.
    if jtTextoBusqueda.blank? || jtTextoBusqueda.to_s == ''
    	@proximos_viajes = []
    	@viajes = Viaje.select("*").where("estadoviaje_id = 2 or estadoviaje_id = 1")
    	@viajes.each do |viaje|
    		proximo_viaje = Hash.new
    		proximo_viaje[:viaje_id] = viaje.id
    		proximo_viaje[:fecha] = viaje.fecha.strftime("%d, %b %y")
    		proximo_viaje[:hora_salida] = viaje.horainicio.strftime("%I:%M%p")
    		proximo_viaje[:hora_llegada] = (viaje.horainicio+ viaje.ruta.paradas.sum(:tiempo).to_i).strftime("%I:%M%p")
    		proximo_viaje[:origen] = viaje.ruta.paradas.order('posicion ASC').first.nombre
    		proximo_viaje[:destino] = viaje.ruta.paradas.order('posicion ASC').last.nombre
    		@proximos_viajes<<proximo_viaje
    	end
    	    	@proximos_viajes.sort_by! { |proximo_viaje| proximo_viaje[:"#{jtSorting}"] }
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
                      :TotalRecordCount => Viaje.where("estadoviaje_id = 2 or estadoviaje_id = 1").count,
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
    jtStartPage = jtStartIndex.to_i / jtPageSize.to_i + 1

    # Si el campo de busqueda tiene solo espacios en blanco.
    if jtTextoBusqueda.blank? || jtTextoBusqueda.to_s == ''
    	@realizados_viajes = []
    	@viajes = Viaje.select("*").where("estadoviaje_id = 3")
    	@viajes.each do |viaje|
    		realizado_viaje = Hash.new
    		realizado_viaje[:viaje_id] = viaje.id
    		realizado_viaje[:fecha] = viaje.fecha.strftime("%d, %b %y")
    		realizado_viaje[:hora_salida] = viaje.horainicio.strftime("%I:%M%p")
    		realizado_viaje[:hora_llegada] = (viaje.horainicio+ viaje.ruta.paradas.sum(:tiempo).to_i).strftime("%I:%M%p")
    		realizado_viaje[:origen] = viaje.ruta.paradas.order('posicion ASC').first.nombre
    		realizado_viaje[:destino] = viaje.ruta.paradas.order('posicion ASC').last.nombre
    		@realizados_viajes<<realizado_viaje
    	end
    	    	@realizados_viajes.sort_by! { |realizado_viaje| realizado_viaje[:"#{jtSorting}"] }
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
                      :TotalRecordCount => Viaje.where("estadoviaje_id = 3").count,
                      :Records => @results
                      }
      format.json { render json: jTableResult}
      format.html
      format.js
    end
  end#realizados_jtable

end
