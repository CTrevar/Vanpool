class ConductorsController < ApplicationController
  # GET /conductors
  # GET /conductors.json
  def index
    @conductors = Conductor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @conductors }
    end
  end

  # GET /conductors/1
  # GET /conductors/1.json
  def show
    @conductor = Conductor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @conductor }
    end
  end

  # GET /conductors/new
  # GET /conductors/new.json
  def new
    @conductor = Conductor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @conductor }
    end
  end

  # GET /conductors/1/edit
  def edit
    @conductor = Conductor.find(params[:id])
  end

  # POST /conductors
  # POST /conductors.json
  # def create
  #   @conductor = Conductor.new(params[:conductor])
  #
  #   respond_to do |format|
  #     if @conductor.save
  #       format.html { redirect_to @conductor, notice: 'Conductor was successfully created.' }
  #       format.json { render json: @conductor, status: :created, location: @conductor }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @conductor.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PUT /conductors/1
  # PUT /conductors/1.json
  # def update
  #   @conductor = Conductor.find(params[:id])
  #
  #   respond_to do |format|
  #     if @conductor.update_attributes(params[:conductor])
  #       format.html { redirect_to @conductor, notice: 'Conductor was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @conductor.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /conductors/1
  # DELETE /conductors/1.json
  def destroy
    @conductor = Conductor.find(params[:id])
    @conductor.destroy

    respond_to do |format|
      format.html { redirect_to conductors_url }
      format.json { head :no_content }
    end
  end




  # Método para crear un conductor a través de la forma del panel lateral.
  # POST /conductors
  # POST /conductors.json
  def create
    paramsconductor = OpenStruct.new params[:conductor]
    paramsuser = OpenStruct.new paramsconductor.user
    @conductor = Conductor.new
    user = User.new
    user.attributes = {:name => paramsuser.name, :email => paramsuser.email,
                       :fechaNacimiento => paramsuser.fechaNacimiento,
                       :apellidoPaterno => paramsuser.apellidoPaterno,
                       :apellidoMaterno => paramsuser.apellidoMaterno,
                       :password => paramsuser.password,
                       :password_confirmation => paramsuser.password_confirmation}
    @conductor.user = user
    @conductor.attributes = {:licenciaConductor => paramsconductor.licenciaConductor}
    @action = 'create'
    if @conductor.valid?
      if @conductor.user.save!
        @conductor.attributes = {:user_id =>@conductor.user.id, :estatusConductor => 1}
        if @conductor.save!
          respond_to do |format|
            # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
            format.html { render partial: 'administradors/form_conductor', conductor:@conductor, locals: {exito:true}, create: true}
          end
        else
          # eliminamos el usuario creado
          User.destroy(@conductor.user.id)
          respond_to do |format|
            # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
            format.html { render partial: 'administradors/form_conductor', conductor:@conductor, create: true }
            format.json { render json: @conductor.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
          format.html { render partial: 'administradors/form_conductor', conductor:@conductor, create: true }
          format.json { render json: @conductor.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
        format.html { render partial: 'administradors/form_conductor', conductor:@conductor, create: true }
        format.json { render json: @conductor.errors, status: :unprocessable_entity }
      end
    end
  end

  # Método para actualizar los datos de un conductor a través de la forma del panel lateral.
  def update
    paramsconductor = OpenStruct.new params[:conductor]
    paramsuser = OpenStruct.new paramsconductor.user
    @conductor = Conductor.find(paramsconductor.id)

    if paramsuser.password.present?
      @conductor.user.attributes = {:name => paramsuser.name, :email => paramsuser.email,
                                    :fechaNacimiento => paramsuser.fechaNacimiento,
                                    :apellidoPaterno => paramsuser.apellidoPaterno,
                                    :apellidoMaterno => paramsuser.apellidoMaterno,
                                    :password => paramsuser.password,
                                    :password_confirmation => paramsuser.password_confirmation }
    else
      @conductor.user.attributes = {:name => paramsuser.name, :email => paramsuser.email,
                                    :fechaNacimiento => paramsuser.fechaNacimiento,
                                    :apellidoPaterno => paramsuser.apellidoPaterno,
                                    :apellidoMaterno => paramsuser.apellidoMaterno}
    end
    
    @conductor.attributes = { :licenciaConductor => paramsconductor.licenciaConductor }
    @action = 'update'
    if @conductor.valid?
      @conductor.save!
      respond_to do |format|
        # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
        format.html { render partial: 'administradors/form_conductor', conductor:@conductor, locals: {exito:true}}
      end
    else
      respond_to do |format|
        # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
        format.html { render partial: 'administradors/form_conductor', conductor:@conductor }
        format.json { render json: @conductor.errors, status: :unprocessable_entity }
      end
    end
  end

  def registrar_subida
    reserva_id = params[:reserva_id]
    @reservacion = Reservacion.find(reserva_id)
    if @reservacion.estadotipo_id == 3
      @reservacion[:resultado] = "Ya se habia registrado la subida del usuario"
    else
      checkin(reserva_id)
      @reservacion = Reservacion.find(reserva_id)
      if @reservacion.estadotipo_id == 3
        @reservacion[:resultado] = "Subida registrada"
      else
        @reservacion[:resultado] = "No se pudo registrar la subida"
      end
    end
    render json:@reservacion
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

    # Convertimos los valores para que puedan ser procesados por posgresql
    jtSorting = jtSorting.gsub(/(licenciaConductor)/i, '"licenciaConductor"')
    jtSorting = jtSorting.gsub(/(apellidoMaterno)/i, '"apellidoMaterno"')
    jtSorting = jtSorting.gsub(/(apellidoPaterno)/i, '"apellidoPaterno"')
    jtSorting = jtSorting.gsub(/(fechaNacimiento)/i, '"fechaNacimiento"')
    jtSorting = jtSorting.gsub(/(idTipoUsuario)/i, '"idTipoUsuario"')
    jtSorting = jtSorting.gsub(/(estatusConductor)/i, '"estatusConductor"')
    # Si el campo de busqueda tiene solo espacios en blanco.
    if jtTextoBusqueda.blank? || jtTextoBusqueda.to_s == ''
      @results = Conductor.joins(:user).select('*').where("\"estatusConductor\" = 't'").order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    else
      jtTextoBusqueda = jtTextoBusqueda.gsub("'", %q(\\\'))
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = Conductor.joins(:user).select('*')
                                        .where("(\"licenciaConductor\" ILIKE :search OR
                                                 name ILIKE :search OR
                                                 \"apellidoMaterno\" ILIKE :search OR
                                                 \"apellidoPaterno\" ILIKE :search OR
                                                 email ILIKE :search OR
                                                 to_char(\"fechaNacimiento\", 'MM/DD/YYYY') ILIKE :search
                                                ) AND \"estatusConductor\" = 't'", search:"%#{jtTextoBusqueda.strip}%").select('*').order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    end
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => @results.count,
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
    conductor = Conductor.find_by_user_id(params[:id])

    # Iniciamos la eliminación del registro, si no se elimina, almacenamos el resultado en un boleano.
    bolExito = true
    errMensaje = ''
    begin
      conductor.estatusConductor = false
      conductor.save!
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
