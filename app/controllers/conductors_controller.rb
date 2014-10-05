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


  def update
    paramsconductor = OpenStruct.new params[:conductor]
    paramsuser = OpenStruct.new paramsconductor.user
    @conductor = Conductor.find(paramsconductor.id)

    @conductor.user.attributes = { :name => paramsuser.name, :email => paramsuser.email,
                                                :fechaNacimiento => paramsuser.fechaNacimiento,
                                                :apellidoPaterno => paramsuser.apellidoPaterno,
                                                :apellidoMaterno => paramsuser.apellidoMaterno }
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
      @results = Conductor.joins(:user).select('*').where("estatusConductor = 't'").order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    else
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = Conductor.joins(:user).select('*')
                                        .where("(LOWER(licenciaConductor) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(name) LIKE '%#{jtTextoBusqueda.downcase}%' OR
                                                 LOWER(apellidoMaterno) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(apellidoPaterno) LIKE '%#{jtTextoBusqueda.downcase}%' OR
                                                 LOWER(email) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(estatusConductor) LIKE '%#{jtTextoBusqueda.downcase}%' OR
                                                 LOWER(facebookidUsuario) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(fechaNacimiento) LIKE '%#{jtTextoBusqueda.downcase}%' OR
                                                 LOWER(idTipoUsuario) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(openpayidUsuario) LIKE '%#{jtTextoBusqueda.downcase}%'
                                                ) AND estatusConductor = 't'").select('*').order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
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
    # User
    id = params[:id]
    name = params[:name]
    apellidopaterno = params[:apellidoPaterno]
    apellidomaterno = params[:apellidoMaterno]
    email = params[:email]
    estatususuario = params[:estatusUsuario]
    fechanacimiento = params[:fechaNacimiento]
    idtipousuario = params[:idTipoUsuario]
    openpayidusuario = params[:openpayidUsuario]

    # Conductor
    user_id = params[:user_id]
    licenciaconductor = params[:licenciaConductor]
    estatusconductor = params[:estatusConductor]


    # Iniciamos la actualización del registro, si no se acutaliza, almacenamos el resultado en un boleano.
    bolexito = false
    errmensaje = ""
    # begin
      actualrowuser = User.find(id)
      actualrowconductor = Conductor.find_by_user_id(actualrowuser.id)
      if actualrowconductor.present? && actualrowuser.present?
        actualrowuser.attributes = {:name => name, :email => email,
                                    :fechaNacimiento => fechanacimiento,:apellidoPaterno => apellidopaterno, :apellidoMaterno => apellidomaterno
                                    }
        actualrowconductor.attributes = { :licenciaConductor => licenciaconductor, :estatusConductor => estatusconductor }
      end

      if actualrowuser.valid? && actualrowconductor.valid?
        actualrowuser = actualrowuser.save!
        actualrowconductor = actualrowconductor.save!
        bolexito = true
      else
        errmensaje = "No se pudo actualizar.</br>"
        errmensaje += actualrowconductor.errors.messages.to_s + '</br>'
        errmensaje += actualrowuser.errors.messages.to_s
      end
    actualrow = Conductor.joins(:user).select('*').where("user_id = #{id}")
    # rescue => e
    #   errmensaje += "</br>No se pudo actualizar.</br>Revise el error: </br><em> #{e}</em>"
    # end
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
