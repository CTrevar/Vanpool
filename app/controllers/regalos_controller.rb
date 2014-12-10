class RegalosController < ApplicationController

  #
  # Metodo para crear promociones de regalos
  #
  def create
    paramsregalopromocion = OpenStruct.new params[:regalo]
    @regalopromocion = Regalo.new
    @regalopromocion.attributes =  {:nombre => paramsregalopromocion.nombre,
                                    :descripcion => paramsregalopromocion.descripcion,
                                    :perfil_id => (OpenStruct.new params[:regalopromocion]).perfil_id,
                                    :estatus => true}
    @regalopromocion.medalla = Medalla.find((OpenStruct.new params[:regalopromocion]).medalla_id)
    @action = 'create'
    if @regalopromocion.valid?
      if @regalopromocion.save!
        respond_to do |format|
          format.html { render partial: "administradors/form_regalopromocion", regalopromocion:@regalopromocion, locals: {exito:true}, create: true}
        end
      else
        respond_to do |format|
          format.html { render partial: 'administradors/form_regalopromocion', regalopromocion:@regalopromocion }
          format.json { render json: @regalopromocion.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render partial: 'administradors/form_regalopromocion', regalopromocion:@regalopromocion }
        format.json { render json: @regalopromocion.errors, status: :unprocessable_entity }
      end
    end
  end

  #
  # Metodo para actualizar promociones de regalos
  #
  def update
    paramsregalopromocion = OpenStruct.new params[:regalo]
    @regalopromocion = Regalo.new
    @regalopromocion = Regalo.find(paramsregalopromocion.id)
    @regalopromocion.attributes ={:nombre => paramsregalopromocion.nombre,
                                  :descripcion => paramsregalopromocion.descripcion }
    medalla = OpenStruct.new paramsregalopromocion.medalla
    @regalopromocion.medalla_id = medalla.medalla_id
    @regalopromocion.medalla = Medalla.find(medalla.medalla_id)

    @regalopromocion.perfil_id = (OpenStruct.new params[:regalopromocion]).perfil_id
    @regalopromocion.perfil = Perfil.find(@regalopromocion.perfil_id)

    @action = 'update'
    if @regalopromocion.valid?
      @regalopromocion.save!
      respond_to do |format|
        format.html { render partial: "administradors/form_regalopromocion", regalopromocion:@regalopromocion, locals: {exito:true}}
      end
    else
      respond_to do |format|
        format.html { render partial: 'administradors/form_regalopromocion', regalopromocion:@regalopromocion }
        format.json { render json: @regalopromocion.errors, status: :unprocessable_entity }
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
      @results = Regalo.joins(:medalla).joins(:perfil).where("regalos.estatus = 't'")
      .select('perfils.id, perfils.nombre as perfil_nombre, regalos.id, regalos.nombre, regalos.descripcion, medallas.id as medalla_id, medallas.nombre as medalla_nombre,
                                                        medallas.estatus,  medallas.estado, medallas.imagen, medallas.puntos'
      ).order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    else
      @query = "( regalos.nombre ILIKE :search OR
                  medallas.nombre ILIKE :search OR
                  regalos.descripcion ILIKE :search OR
                  perfils.nombre ILIKE :search
                  ) AND regalos.estatus = 't'"
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = Regalo.joins(:medalla).joins(:perfil).where(@query,search: "%#{jtTextoBusqueda.strip}%")
      .select('perfils.id, perfils.nombre as perfil_nombre, regalos.id, regalos.nombre, regalos.descripcion, medallas.id, medallas.nombre as medalla_nombre,
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
    @regalopromocion = Regalo.find(params[:id])

    # Iniciamos la eliminación del registro, si no se elimina, almacenamos el resultado en un boleano.
    bolExito = true
    errMensaje = ''
    begin
      @regalopromocion.estatus = false
      @regalopromocion.save!
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
