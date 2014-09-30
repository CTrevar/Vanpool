class AdministradorsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :listadministradores, :listareportes]
  # GET /administradors
  # GET /administradors.json
  def index
    @administradors = Administrador.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: AdministradorsDatatable.new(view_context) }
    end
  end

  # GET /administradors/1
  # GET /administradors/1.json
  def show
    @administrador = Administrador.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @administrador }
    end
  end

  # GET /administradors/new
  # GET /administradors/new.json
  def new
    @administrador = Administrador.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @administrador }
    end
  end

  # GET /administradors/1/edit
  def edit
    @administrador = Administrador.find(params[:id])
  end

  # POST /administradors
  # POST /administradors.json
  def create
    @administrador = Administrador.new(params[:administrador])

    respond_to do |format|
      if @administrador.save
        format.html { redirect_to @administrador, notice: 'Administrador was successfully created.' }
        format.json { render json: @administrador, status: :created, location: @administrador }
      else
        format.html { render action: "new" }
        format.json { render json: @administrador.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /administradors/1
  # PUT /administradors/1.json
  def update
    @administrador = Administrador.find(params[:id])

    respond_to do |format|
      if @administrador.update_attributes(params[:administrador])
        format.html { redirect_to @administrador, notice: 'Administrador was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @administrador.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administradors/1
  # DELETE /administradors/1.json
  def destroy
    @administrador = Administrador.find(params[:id])
    @administrador.destroy

    respond_to do |format|
      format.html { redirect_to administradors_url }
      format.json { head :no_content }
    end
  end


  def listadministradores
    respond_to do |format|
      format.html
      format.json { render json: AdministradorsDatatable.new(view_context) }
    end

  end

  def listareportes
    @reportes=Reporte.find_all_by_estatus(true)
    render 'show_reportes'
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

    @results = Administrador.order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => Administrador.count,
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
      @results = Administrador.order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    else
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = Administrador.where( "LOWER(apellidoMaterno) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(apellidoPaterno) LIKE '%#{jtTextoBusqueda.downcase}%' OR
                                       LOWER(emailUsuario) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(estatusUsuario) LIKE '%#{jtTextoBusqueda.downcase}%' OR
                                       LOWER(facebookidUsuario) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(fechaNacimiento) LIKE '%#{jtTextoBusqueda.downcase}%' OR
                                       LOWER(idTipoUsuario) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(nombrePilaUsuario) LIKE '%#{jtTextoBusqueda.downcase}%' OR
                                       LOWER(nombreUsuario) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(openpayidUsuario) LIKE '%#{jtTextoBusqueda.downcase}%'"
      ).order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    end
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => Administrador.count,
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
    @administrador = Administrador.find(params[:id])

    # Iniciamos la eliminación del registro, si no se elimina, almacenamos el resultado en un boleano.
    bolExito = true
    errMensaje = ''
    begin
      @administrador.delete
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
    nombrePilaUsuario = params[:nombrePilaUsuario]
    emailUsuario = params[:emailUsuario]
    apellidoPaterno = params[:apellidoPaterno]
    apellidoMaterno = params[:apellidoMaterno]
    fechaNacimiento = params[:fechaNacimiento]
    estatusUsuario = params[:estatusUsuario]

    # Iniciamos la creación del registro, si no se crea, almacenamos el resultado en un boleano.
    bolexito = false
    errmensaje = ""
    begin
      new = Administrador.new(:nombrePilaUsuario => nombrePilaUsuario, :emailUsuario => emailUsuario,
                              :apellidoPaterno => apellidoPaterno, :apellidoMaterno => apellidoMaterno,
                              :fechaNacimiento => fechaNacimiento, :estatusUsuario => estatusUsuario)
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

  # ///////////////////////////////////////////////////////
  # Método para actualizar registro en la BD
  #
  def jtable_update
    id = params[:id]
    nombrePilaUsuario = params[:nombrePilaUsuario]
    emailUsuario = params[:emailUsuario]
    apellidoPaterno = params[:apellidoPaterno]
    apellidoMaterno = params[:apellidoMaterno]
    fechaNacimiento = params[:fechaNacimiento]

    # Iniciamos la actualización del registro, si no se acutaliza, almacenamos el resultado en un boleano.
    bolexito = false
    errmensaje = ""
    actualrow = nil
    begin
      actualrow = Administrador.find(id)
      actualrow.attributes = {:nombrePilaUsuario => nombrePilaUsuario, :emailUsuario => emailUsuario,
                              :apellidoPaterno => apellidoPaterno, :apellidoMaterno => apellidoMaterno,
                              :fechaNacimiento => fechaNacimiento}
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
