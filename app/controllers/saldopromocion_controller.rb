class SaldopromocionController < ApplicationController


  def create

  end

  def update

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
      @results = Saldopromocion.joins(:medalla).select('saldopromocions.id, saldopromocions.nombre, saldopromocions.descripcion,
                                                        saldopromocions.cantidad, medallas.id as medalla_id, medallas.nombre as medalla_nombre,
                                                        medallas.estatus,  medallas.estado, medallas.imagen, medallas.puntos'
                                                      ).order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
      # @results = Conductor.joins(:user).select('*').where("\"estatusConductor\" = 't'").order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    else
      @query = "( nombre ILIKE :search OR
                  \"descripcion\" ILIKE :search OR
                  \"cantidad\" ILIKE :search
                  )"
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = Saldopromocion.joins(:medalla).select('saldopromocions.id, saldopromocions.nombre, saldopromocions.descripcion,
                                                        saldopromocions.cantidad, medallas.id, medallas.nombre as medalla_nombre,
                                                        medallas.estatus,  medallas.estado, medallas.imagen, medallas.puntos'
                                                      ).where(@query,search: "%#{jtTextoBusqueda.strip}%").select('*').order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)

    end
    # if jtTextoBusqueda.blank? || jtTextoBusqueda.to_s == ''
    #
    # else
    #   jtTextoBusqueda = jtTextoBusqueda.gsub("'", %q(\\\'))
    #   # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
    #   @results = Conductor.joins(:user).select('*')
    #   .where("(\"licenciaConductor\" ILIKE :search OR
    #                                              name ILIKE :search OR
    #                                              \"apellidoMaterno\" ILIKE :search OR
    #                                              \"apellidoPaterno\" ILIKE :search OR
    #                                              email ILIKE :search OR
    #                                              to_char(\"fechaNacimiento\", 'MM/DD/YYYY') ILIKE :search
    #                                             ) AND \"estatusConductor\" = 't'", search:"%#{jtTextoBusqueda.strip}%").select('*').order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    # end
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => @results.count,
                      :Records => @results
      }
      format.json { render json: jTableResult}
    end
  end
end