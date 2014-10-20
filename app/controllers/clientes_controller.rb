class ClientesController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :dashboard, 
    :profile, :muro, :reservaciones, :checkin, :retro, :reporte, :create_retro, :guardaretro,
    :formapago, :compracredito, :buscarviaje]

  # GET /clientes
  # GET /clientes.json
  def index
    @clientes = Cliente.all
    @cliente = obtener_cliente
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clientes }
    end
  end

  # GET /clientes/1
  # GET /clientes/1.json
  def show
    @cliente = Cliente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cliente }
    end
  end

  # GET /clientes/new
  # GET /clientes/new.json
  def new
    @cliente = Cliente.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cliente }
    end
  end

  # GET /clientes/1/edit
  def edit
    #@cliente = Cliente.find(params[:id])
    #@cliente = obtener_cliente(current_user)
  end

  # POST /clientes
  # POST /clientes.json
  def create
    @cliente = Cliente.new(params[:cliente])
    respond_to do |format|
      if @cliente.save
        format.html { redirect_to @cliente, notice: 'Cliente was successfully created.' }
        format.json { render json: @cliente, status: :created, location: @cliente }
      else
        format.html { render action: "new" }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clientes/1
  # PUT /clientes/1.json
  def update
    @cliente = Cliente.find(params[:id])

    respond_to do |format|
      if @cliente.update_attributes(params[:cliente])
        format.html { redirect_to @cliente, notice: 'Cliente was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.json
  def destroy
    @cliente = Cliente.find(params[:id])
    @cliente.destroy

    respond_to do |format|
      format.html { redirect_to clientes_url }
      format.json { head :no_content }
    end
  end


  
  
  def dashboard
    @current_cliente = obtener_cliente(current_user)
    @reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2).last(3)
    @result=busqueda
    #@result=Viaje.all
    #puts @request_hash["name"]
    #print "hola"

  end


  def compracredito
    @current_cliente = obtener_cliente(current_user)
    
    #puts @request_hash["name"]
    #print "hola"
    render 'show_compra_credito'
  end

  def formapago
    @current_cliente = obtener_cliente(current_user)
    @recarga=params[:cantidad]
    @subtotal=subtotal(@recarga)
    @impuesto=impuesto(@recarga)
    #aspectos.each do |aspecto|
    #  calificacion=params[:"#{aspecto.id}"]
    #  retro = Retroalimentacion.create(reservacion_id:reservacion,aspecto_id:aspecto.id,calificacion:calificacion)
    #end
    #puts @request_hash["name"]
    #print "hola"
    render 'show_pago'
  end

  def subtotal(recarga)
    return (recarga.to_i-impuesto(recarga)).to_d
  end

  def impuesto(recarga)
    imp=Configuracion.find(2).valor
    return recarga.to_i*(imp.to_d/100)
  end

  def detalleviaje
    @current_cliente = obtener_cliente(current_user)
    
    #puts @request_hash["name"]
    #print "hola"
    render 'show_detalleviaje'
  end


  # GET /clientes/1/profile
  def profile
    @title = "Perfil"
    @user = User.find(params[:id])
    @current_cliente=Cliente.find_by_user_id(current_user.id)
    
    @cliente=obtener_cliente(@user)
    @mensaje=obtener_mensaje_nivel(@cliente)
    @validamedallas=valida_medallas(@cliente)
    @muro = obtener_ultimas_medallas(@cliente)
    @co2 = @cliente.co2ahorrado
    @kilometros = @cliente.kilometros

    @reservaciones_pendientes=@current_cliente.reservacions.find_all_by_estadotipo_id(1)
    @reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2)
    @reservaciones_realizadas=@current_cliente.reservacions.find_all_by_estadotipo_id(3)

    #@descuentos=obtener_ultimo_descuento(@cliente)

    render 'show_profile'
  end

  # GET /clientes/1/muro
  def muro
    @title="Muro de medallas"
    @user=User.find(params[:id])
    @current_cliente=Cliente.find_by_user_id(current_user.id)

    @cliente=obtener_cliente(@user)
    @mensaje=obtener_mensaje_nivel(@cliente)
    @validamedallas=valida_medallas(@cliente)
    @muro=obtener_muro(@cliente)
    @co2 = @cliente.co2ahorrado
    @kilometros = @cliente.kilometros
    render 'show_muro'
  end

  # GET /reservaciones
  def reservaciones
    @title="Reservaciones"
    @current_cliente = obtener_cliente(current_user)
    @validareservas=valida_viajes(@cliente)
    @validaviajes=valida_viajes_completos(@cliente)

    @reservaciones_pendientes=@current_cliente.reservacions.find_all_by_estadotipo_id(1)
    @reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2)
    @reservaciones_realizadas=@current_cliente.reservacions.find_all_by_estadotipo_id(3)
    @reservaciones_canceladas=@current_cliente.reservacions.find_all_by_estadotipo_id(4)
    
    render 'show_reservaciones'
  end


  def reporte
    @title="Reporta el servicio"
    @current_cliente = obtener_cliente(current_user)
    @reporte = Reporte.new

    render 'show_reporte'
  end

  def buscarviaje
    @title="Buscar nuevo viaje"
    @current_cliente = obtener_cliente(current_user)
    @reservaciones_pagadas=@current_cliente.reservacions.find_all_by_estadotipo_id(2).last(3)
    @result=busqueda
    #@result=Viaje.all
    render 'show_nuevo_viaje'
  end

  def comprar
    
    redirect_to :controller => 'clientes', :action => 'formapago'
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
    jtAtributoCondicion = params[:atributoCondicion]
    jtCondicion = params[:condicion]
    jtValorCondicion = params[:valorCondicion]
    jtSorting = params[:jtSorting]
    jtStartIndex = params[:jtStartIndex]
    jtPageSize = params[:jtPageSize]
    jtStartPage = jtStartIndex.to_i / jtPageSize.to_i + 1
    @queryFiltrado = ""
    @query = ""
    # Si el campo de busqueda tiene solo espacios en blanco.
    if jtTextoBusqueda.blank? || jtTextoBusqueda.to_s == ''
      if jtAtributoCondicion.present? && jtCondicion.present? && jtValorCondicion.present?
        @results = Cliente.joins(:user).select('*').where(" #{jtAtributoCondicion} #{jtCondicion} #{jtValorCondicion} AND clientes.estatus = 't'").joins(:nivel).select('clientes.id as cliente_id, nombre as nombre_nivel, nivels.estatus as estatus_nivel, nivels.id as nivel_id').order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
      else
        @results = Cliente.joins(:user).select('*').where("clientes.estatus = 't'").joins(:nivel).select('clientes.id as cliente_id, nombre as nombre_nivel, nivels.estatus as estatus_nivel, nivels.id as nivel_id').order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
      end
    else
      if jtAtributoCondicion.present? && jtCondicion.present? && jtValorCondicion.present?
          @queryFiltrado = " AND ( #{jtAtributoCondicion} #{jtCondicion} #{jtValorCondicion} ) "
      end
      @query = "(LOWER(name) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(apellidoMaterno) LIKE '%#{jtTextoBusqueda.downcase}%' OR
                 LOWER(apellidoPaterno) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(email) LIKE '%#{jtTextoBusqueda.downcase}%' OR
                 LOWER(fechaNacimiento) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(facebookidUsuario) LIKE '%#{jtTextoBusqueda.downcase}%' OR
                 LOWER(openpayidUsuario) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(idTipoUsuario) LIKE '%#{jtTextoBusqueda.downcase}%' OR
                 LOWER(nivels.nombre) LIKE '%#{jtTextoBusqueda.downcase}%'
                ) #{@queryFiltrado} AND clientes.estatus = 't'"
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results =  Cliente.joins(:user).select('*').joins(:nivel).select('nombre as nombre_nivel, nivels.estatus as estatus_nivel, nivels.id as nivel_id, clientes.id as cliente_id')
      .where(@query).select('*').order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    end
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => @results.count,
                      :Records => @results
      }
      format.json { render json: jTableResult}
      # format.html
      # format.js
    end
  end

  # ///////////////////////////////////////////////////////
  # Método para eliminar registro de la BD
  #
  def jtable_delete
    cliente = Cliente.find(params[:cliente_id])

    # Iniciamos la eliminación del registro, si no se elimina, almacenamos el resultado en un boleano.
    bolExito = true
    errMensaje = ''
    begin
      cliente.estatus= false
      cliente.save!
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

  private
  end




