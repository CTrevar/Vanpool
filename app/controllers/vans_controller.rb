class VansController < ApplicationController
  def new
    @van = Van.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @van}
    end
  end

  def create
    @van = Van.new(params[:van])
    @van.estatus= true
    @van.activa = true

    # @van.save

    # if @van.save
    #   redirect_to vans_path
    # else
    #   render 'new'
    # end


    #@conductor.user = user
    @action = 'create'
    if @van.valid?
        if @van.save!
          respond_to do |format|
            # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
            format.html { render partial: 'administradors/form_van', van:@van, locals: {exito:true}, create: true}
          end
        else
          respond_to do |format|
            # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
            format.html { render partial: 'administradors/form_van', van:@van, create: true }
            format.json { render json: @van.errors, status: :unprocessable_entity }
          end
        end
    else
      respond_to do |format|
        # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
        format.html { render partial: 'administradors/form_van', medalla:@van, create: true }
        format.json { render json: @van.errors, status: :unprocessable_entity }
      end
    end
    
    
  end

  def show
    @van = Van.find(params[:id])
  end

  def index
    @vans = Van.all
    van_id = params[:id]
    if van_id.nil?
      @van = Van.new
      @action = 'create'
    else
      @van = Van.find(van_id)
      @action = 'update'
    end
  end

  def destroy
    @van = Van.find (params[:id])
    @van.destroy
    redirect_to vans_path
  end

  def edit
    @van = Van.find(params[:id])
  end

  def update
    @van = Van.find(params[:van][:id])
    if @van.update_attributes(params[:van])
      respond_to do |format|
        format.html { render partial: 'shared/administrador_detallevan', van:@van}
      end
    else
      #render 'edit'
    end

  end



# ///////////////////////////////////////////////////////
  # Método para listar SIN buscar los registros de la BD
  #
  def jtable_list

    jtSorting = params[:jtSorting]
    jtStartIndex = params[:jtStartIndex]
    jtPageSize = params[:jtPageSize]
    jtStartPage = jtStartIndex.to_i / jtPageSize.to_i + 1

    @results = Van.order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => Van.count,
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
      @results = Van.order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    else
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = Van.where( "LOWER(placa) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(modelo) LIKE '%#{jtTextoBusqueda.downcase}%' OR
                                       LOWER(capacidad) LIKE '%#{jtTextoBusqueda.downcase}%'"
      ).order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    end
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => Van.count,
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
    @van = Van.find(params[:id])

    # Iniciamos la eliminación del registro, si no se elimina, almacenamos el resultado en un boleano.
    bolExito = true
    errMensaje = ''
    begin
      @van.delete
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

  # ///////////////////////////////////////////////////////
  # Método para crear registro en la BD
  #
  def jtable_create
    capacidad = params[:capacidad]
    modelo = params[:modelo]
    fecha_compra = params[:fecha_compra]
    placa = params[:placa]

    # Iniciamos la creación del registro, si no se crea, almacenamos el resultado en un boleano.
    bolexito = false
    errmensaje = ""
    begin
      new = Van.new(:capacidad => capacidad, :modelo => modelo,
                              :fecha_compra => fecha_compra, :placa => placa,
                              :estatus => true, :activa => true)
      if new.invalid?
        errmensaje = "No se pudo crear.</br>"
        errmensaje += new.errors.messages.to_s
      else
        new = new.save!
        bolexito = true
      end
    rescue => e
      errmensaje += "</br>No se pudo crear.</br>Revise el error: </br><em> #{e}</em>"
    end
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      if bolexito
        jTableResult = {:Result => "OK",
                        :Record => new}
      else
        jTableResult = {:Result => "Message",
                        :Message => errmensaje}
      end
      format.json { render json: jTableResult}
      format.html
      format.js
    end
  end

  def jtable_update
    id = params[:id]
    capacidad = params[:capacidad]
    modelo = params[:modelo]
    fecha_compra = params[:fecha_compra]
    placa = params[:placa]

    # Iniciamos la actualización del registro, si no se acutaliza, almacenamos el resultado en un boleano.
    bolexito = false
    errmensaje = ""
    actualrow = nil
    begin
      actualrow = Van.find(id)
      actualrow.attributes = {:capacidad => capacidad, :modelo => modelo,
                              :fecha_compra => fecha_compra, :placa => placa}
      if actualrow.invalid?
        errmensaje = "No se pudo actualizar.</br>"
        errmensaje += actualrow.errors.messages.to_s
      else
        actualrow = actualrow.save!
        bolexito = true
      end
    rescue => e
      errmensaje += "</br>No se pudo crear.</br>Revise el error: </br><em> #{e}</em>"
    end
    # Regresamos el resultado de la operación a la jTable
    respond_to do |format|
      if bolexito
        jTableResult = {:Result => "OK",
                        :Record => actualrow}
      else
        jTableResult = {:Result => "Message",
                        :Message => errmensaje}
      end
      format.json { render json: jTableResult}
      format.html
      format.js
    end
  end
  


end