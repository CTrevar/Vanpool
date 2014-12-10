class SaldopromocionsController < ApplicationController

  #
  # Metodo para crear promociones de saldo
  #
  def create
    paramssaldopromocion = OpenStruct.new params[:saldopromocion]
    @saldopromocion = Saldopromocion.new
    @saldopromocion.attributes =  { :nombre => paramssaldopromocion.nombre,
                                    :descripcion => paramssaldopromocion.descripcion,
                                    :cantidad => paramssaldopromocion.cantidad,
                                    :estatus => true}
    @saldopromocion.medalla = Medalla.find(paramssaldopromocion.medalla_id)
    @action = 'create'
    if @saldopromocion.valid?
      if @saldopromocion.save!
        respond_to do |format|
          format.html { render partial: "administradors/form_saldopromocion", saldopromocion:@saldopromocion, locals: {exito:true}, create: true}
        end
      else
        respond_to do |format|
          format.html { render partial: 'administradors/form_saldopromocion', saldopromocion:@saldopromocion }
          format.json { render json: @saldopromocion.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render partial: 'administradors/form_saldopromocion', saldopromocion:@saldopromocion }
        format.json { render json: @saldopromocion.errors, status: :unprocessable_entity }
      end
    end
  end

  #
  # Metodo para actualizar promociones de saldo
  #
  def update
    paramssaldopromocion = OpenStruct.new params[:saldopromocion]
    @saldopromocion = Saldopromocion.new
    @saldopromocion = Saldopromocion.find(paramssaldopromocion.id)
    @saldopromocion.attributes ={:nombre => paramssaldopromocion.nombre,
                                 :descripcion => paramssaldopromocion.descripcion,
                                 :cantidad => paramssaldopromocion.cantidad }
    medalla = OpenStruct.new paramssaldopromocion.medalla
    # @saldopromocion.medalla_id = medalla.medalla_id
    @saldopromocion.medalla_id = paramssaldopromocion.medalla_id
    @saldopromocion.medalla = Medalla.find(medalla.medalla_id)
    @action = 'update'
    if @saldopromocion.valid?
      @saldopromocion.save!
      respond_to do |format|
        format.html { render partial: "administradors/form_saldopromocion", saldopromocion:@saldopromocion, locals: {exito:true}}
      end
    else
      respond_to do |format|
        format.html { render partial: 'administradors/form_saldopromocion', saldopromocion:@saldopromocion }
        format.json { render json: @saldopromocion.errors, status: :unprocessable_entity }
      end
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
      @results = Saldopromocion.joins(:medalla).where("saldopromocions.estatus = 't'")
                                               .select('saldopromocions.id, saldopromocions.nombre, saldopromocions.descripcion,
                                                        saldopromocions.cantidad, medallas.id as medalla_id, medallas.nombre as medalla_nombre,
                                                        medallas.estatus,  medallas.estado, medallas.imagen, medallas.puntos'
                                                      ).order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
      # @results = Conductor.joins(:user).select('*').where("\"estatusConductor\" = 't'").order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    else
      @query = "( saldopromocions.nombre ILIKE :search OR
                  medallas.nombre ILIKE :search OR
                  saldopromocions.descripcion ILIKE :search OR
                  to_char(\"cantidad\",'999D99S') ILIKE :search
                  ) AND saldopromocions.estatus = 't'"
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = Saldopromocion.joins(:medalla).where(@query,search: "%#{jtTextoBusqueda.strip}%")
                                               .select('saldopromocions.id, saldopromocions.nombre, saldopromocions.descripcion,
                                                        saldopromocions.cantidad, medallas.id, medallas.nombre as medalla_nombre,
                                                        medallas.estatus,  medallas.estado, medallas.imagen, medallas.puntos'
                                                      ).order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)

    end
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => @results.count,
                      :Records => @results
      }
      format.json { render json: jTableResult}
    end
  end

  # ///////////////////////////////////////////////////////
  # Método para eliminar registro de la BD
  #
  def jtable_delete
    @saldopromocion = Saldopromocion.find(params[:id])

    # Iniciamos la eliminación del registro, si no se elimina, almacenamos el resultado en un boleano.
    bolExito = true
    errMensaje = ''
    begin
      @saldopromocion.estatus = false
      @saldopromocion.save!
    rescue => e
      bolExito = false
      errMensaje = "No se pudo eliminar. Revise el error: #{e}"
    end
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      if bolExito
        jTableResult = {:Result => "OK"}
      else
        jTableResult = {:Result => "Message",
                        :Message => errMensaje}
      end
      format.json { render json: jTableResult}
      format.html
      format.js
    end
  end
end