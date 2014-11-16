class SugerenciasController < ApplicationController

  def borrar_sugerencia
    sugerencia_id = params[:sugerencia_id]
    sugerencia = Sugerencia.find(sugerencia_id)

    sugerencia_paradas = Sugerenciaparada.where("sugerencia_id = ?", sugerencia_id)
    sugerencia_paradas.each do |sug_parada|
      sug_parada.destroy
    end

    cercanas_id = params[:cercanas_id]
    sugerencias_count = 1
    

    if !cercanas_id.nil? 
      sugerencias_count += cercanas_id.count
      cercanas_id.each do |cercana_id|
        sug = Sugerencia.find(cercana_id)
        sug_cercana_paradas = Sugerenciaparada.where("sugerencia_id = ?",sug.id)
        sug_cercana_paradas.each do |sug_cercana_parada|
          sug_cercana_parada.destroy
        end
        sug.destroy
      end
    end
    sugerencia.destroy

    @mensaje =""
    if sugerencias_count == 1
      @mensaje = "Se borro 1 sugerencia"
    else
      @mensaje = "Se borraron #{sugerencias_count} sugerencias"
    end

    respond_to do |format|
        format.html {render partial: 'shared/administrador_mensajesugerencia', locals: { mensaje: @mensaje }}
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

    @results = Sugerencia.order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => Sugerencia.count,
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
      @results = Sugerencia.select(" sugerencias.id as sugerencia_id, *").order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    else
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = Sugerencia.select(" sugerencias.id as sugerencia_id, *").where( "LOWER(hora_inicio) LIKE '%#{jtTextoBusqueda.downcase}%'"
      ).order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    end
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => Sugerencia.count,
                      :Records => @results
                      }
      format.json { render json: jTableResult}
      format.html
      format.js
    end
  end

end