class AdministradorsController < ApplicationController
  protect_from_forgery with: :exception
  before_filter :admin_user, only: [:index, :create , :update, :show, :new, :edit, :destroy,
   :listadministradores,:listareportes, :reporteretros, :inicio, :sugerencias,
    :medallas,:administradores, :clientes, :conductores],
    except:[:administrador_detallecliente, :administrador_detallevan]

  
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
  # def create
  #   @administrador = Administrador.new(params[:administrador])
  #
  #   respond_to do |format|
  #     if @administrador.save
  #       format.html { redirect_to @administrador, notice: 'Administrador was successfully created.' }
  #       format.json { render json: @administrador, status: :created, location: @administrador }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @administrador.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PUT /administradors/1
  # # PUT /administradors/1.json
  # def update
  #   @administrador = Administrador.find(params[:id])
  #
  #   respond_to do |format|
  #     if @administrador.update_attributes(params[:administrador])
  #       format.html { redirect_to @administrador, notice: 'Administrador was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @administrador.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

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

  def inicio
    render 'show_inicio'

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
  #
  # Metodo para desplegar la información de ruta en un div lateral.
  #
  def administrador_detallevan
    van_id = params[:id]
    @van = Van.new
    @van = Van.find(van_id)
      
    if van_id.nil?
      @action = 'create'
    else
      @van = Van.find(van_id)
      
      @action = 'update'
      respond_to do |format|
        #format.html {render layout:false}
        format.html { render partial: 'shared/administrador_detallevan', locals: { van: @van, action: @action }, layout:false}
        
      end
    end
  end


  #
  # Metodo para desplegar la información básica de un conductor en un div lateral.
  #
  def conductores
    user_id = params[:user_id]
    if user_id.nil?
      @conductor = Conductor.new
      @conductor.user = User.new
      @action = 'create'
      # respond_to do |format|
      #   format.html #listaconductores.html.erb
      # end
    else
      @conductor = Conductor.find_by_user_id(user_id)
      @action = 'update'
      respond_to do |format|
        format.html {render partial: 'shared/administrador_detalleconductor', locals: { conductor: @conductor, aciton: @action }}
      end
    end
  end
  #
  # Metodo para desplegar la información básica de administrador en un div lateral.
  #
  def administradores
    user_id = params[:id]
    if user_id.nil?
      @administrador = User.new
      @action = 'create'
      # respond_to do |format|
      #   format.html #listaconductores.html.erb
      # end
    else
      @administrador = User.find(user_id)
      @action = 'update'
       respond_to do |format|
         format.html {render partial: 'shared/administrador_detalleadministrador', locals: { administrador: @administrador, aciton: @action }}
       end
    end
  end
  #
  # Metodo para ver el detalle de la información de un administrador.
  #
  def administrador_detalleadministrador
    user_id = params[:id]
    if user_id.nil?
      @administrador = User.new
      @action = 'create'
      # respond_to do |format|
      #   format.html #listaconductores.html.erb
      # end
    else
      @administrador = User.find(user_id)
      @action = 'update'
      respond_to do |format|
        format.html { render partial: 'shared/administrador_detalleadministrador', locals: { cliente: @cliente, aciton: @action }, layout:false}
        # format.html {render layout:false}
      end
    end
  end
  #
  # Metodo para ver información básica de un cliente en un div lateral
  #
  def clientes
    cliente_id = params[:cliente_id]
    if cliente_id.nil?
      @cliente = Cliente.new
      @action = 'create'
    else
      @cliente = Cliente.find(cliente_id)
      @action = 'update'
    end
  end
  #
  # Metodo para ver el detalle de la información de un cliente.
  #
  def administrador_detallecliente
    cliente_id = params[:cliente_id]
    @cliente = Cliente.new
    if cliente_id.nil?
      @action = 'create'
    else
      @cliente = Cliente.find(cliente_id)
      @cliente.user = User.find(@cliente.user_id)
      @action = 'update'
      respond_to do |format|
        format.html { render partial: 'shared/administrador_detallecliente', locals: { cliente: @cliente, aciton: @action }, layout:false}
        # format.html {render layout:false}
      end
    end
  end

  #
  # Metodo para ver información básica de un cliente en un div lateral
  #
  def medallas
    medalla_id = params[:medalla_id]
    if medalla_id.nil?
      @medalla = Medalla.new
      @action = 'create'
    else
      @medalla = Medalla.find(medalla_id)
      @action = 'update'
    end
  end
  #
  # Metodo para ver el detalle de la información de un cliente.
  #
  def administrador_detallemedalla
    medalla_id = params[:medalla_id]
    @medalla = Medalla.new
    #@medalla = Medalla.find(medalla_id)

    if medalla_id.nil?
      @action = 'create'
    else
      @medalla = Medalla.find(medalla_id)
      @action = 'update'
      respond_to do |format|
        format.html { render partial: 'shared/administrador_detallemedalla', locals: { medalla: @medalla, aciton: @action }, layout:false}
        # format.html {render layout:false}
      end
    end
  end
  #
  # Metodo para mostrar la página de configuraciones.
  #
  def configuraciones
    @correoBienvenida = Configuracion.find(6)
    @correoRecordatorio = Configuracion.find(7)
    @correoFrecuenciaRecordatorio = Configuracion.find(8)
    @emisionAutomovil = Configuracion.find(1)
    @automovil = Configuracion.find(4)
    @emisionFuente = Configuracion.find(5)
    @emisionFuenteVan = Configuracion.find(9)
    @radio = Configuracion.find(3)
    @impuesto = Configuracion.find(2)
  end
  #
  # Metodo para mostrar la página de configuraciones.
  #
  def cambiar_configuracion
    paramsconf = OpenStruct.new params[:configuracion]
    # Verificamos el id de la configuración
    case paramsconf.id.to_i
      # En caso de ser de cantidad en gramos de CO2 por auto
      when 1
        @emisionAutomovil = Configuracion.new
        @emisionAutomovil = Configuracion.find(paramsconf.id)
        @emisionAutomovil.valor = paramsconf.valor
        if @emisionAutomovil.valid?
          @emisionAutomovil.save!
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_emision_automovil', emisionAutomovil:@emisionAutomovil, locals: {exito:true} }
          end
        else
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_emision_automovil', emisionAutomovil:@emisionAutomovil }
            format.json { render json: @emisionAutomovil.errors, status: :unprocessable_entity }
          end
        end
      # En caso de ser configuracion de impuestos
      when 2
        @impuesto = Configuracion.new
        @impuesto = Configuracion.find(paramsconf.id)
        @impuesto.valor = paramsconf.valor
        if @impuesto.valid?
          @impuesto.save!
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_impuesto', impuesto:@impuesto, locals: {exito:true} }
          end
        else
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_impuesto', impuesto:@impuesto }
            format.json { render json: @impuesto.errors, status: :unprocessable_entity }
          end
        end
      # En caso de ser el radio de búsqueda de los resultados de las rutas
      when 3
        @radio = Configuracion.new
        @radio = Configuracion.find(paramsconf.id)
        @radio.valor = paramsconf.valor
        if @radio.valid?
          @radio.save!
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_radio', radio:@radio, locals: {exito:true} }
          end
        else
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_radio', radio:@radio }
            format.json { render json: @radio.errors, status: :unprocessable_entity }
          end
        end
      # En caso de ser el modelo del auto
      when 4
        @automovil = Configuracion.new
        @automovil = Configuracion.find(paramsconf.id)
        @automovil.valor = paramsconf.valor
        if @automovil.valid?
          @automovil.save!
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_automovil', automovil:@automovil,locals: {exito:true} }
          end
        else
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_automovil', automovil:@automovil }
            format.json { render json: @automovil.errors, status: :unprocessable_entity }
          end
        end
      # En caso de ser la fuente del estudio del CO2
      when 5
        @emisionFuente = Configuracion.new
        @emisionFuente = Configuracion.find(paramsconf.id)
        @emisionFuente.valor = paramsconf.valor
        if @emisionFuente.valid?
          @emisionFuente.save!
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_fuente_co2', emisionFuente:@emisionFuente, locals: {exito:true} }
          end
        else
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_fuente_co2', emisionFuente:@emisionFuente }
            format.json { render json: @emisionFuente.errors, status: :unprocessable_entity }
          end
        end
      # En caso de ser de correo bienvenida
      when 6
        @correoBienvenida = Configuracion.new
        @correoBienvenida = Configuracion.find(paramsconf.id)
        @correoBienvenida.valor = params[:correoBienvenida]#paramsconf.valor
        if @correoBienvenida.valid?
          @correoBienvenida.save!
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_correoBienvenida', correoBienvenida:@correoBienvenida,locals: {exito:true} }
          end
        else
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_correoBienvenida', correoBienvenida:@correoBienvenida }
            format.json { render json: @correoBienvenida.errors, status: :unprocessable_entity }
          end
        end
      # En caso de ser de correo recordatorio
      when 7
        @correoRecordatorio = Configuracion.new
        @correoRecordatorio = Configuracion.find(paramsconf.id)
        @correoRecordatorio.valor = params[:correoRecordatorio]#paramsconf.valor
        if @correoRecordatorio.valid?
          @correoRecordatorio.save!
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_correoRecordatorio', correoRecordatorio:@correoRecordatorio,locals: {exito:true} }
          end
        else
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_correoRecordatorio', correoRecordatorio:@correoRecordatorio }
            format.json { render json: @correoRecordatorio.errors, status: :unprocessable_entity }
          end
        end
      # En caso de ser frecuencia de correo recordatorio
      when 8
        @correoFrecuenciaRecordatorio = Configuracion.new
        @correoFrecuenciaRecordatorio = Configuracion.find(paramsconf.id)
        @correoFrecuenciaRecordatorio.valor = paramsconf.valor
        if @correoFrecuenciaRecordatorio.valid?
          @correoFrecuenciaRecordatorio.save!
          logger.info "\n================================================"
          logger.info "\n"
          logger.info system "sudo whenever --update-crontab"
          # logger.info %x(sh whenever.sh)
          # logger.info %x(whenever -i)
          logger.info `pwd`
          logger.info `ls`
          logger.info "\n"
          logger.info "\n"
          logger.info "\n================================================"
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_correos_frecuencia', correoFrecuenciaRecordatorio:@correoFrecuenciaRecordatorio,locals: {exito:true} }
          end
        else
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_correos_frecuencia', correoFrecuenciaRecordatorio:@correoFrecuenciaRecordatorio }
            format.json { render json: @correoFrecuenciaRecordatorio.errors, status: :unprocessable_entity }
          end
        end
      # En caso de ser el modelo del auto
      when 9
        @emisionFuenteVan = Configuracion.new
        @emisionFuenteVan = Configuracion.find(paramsconf.id)
        @emisionFuenteVan.valor = paramsconf.valor
        if @emisionFuenteVan.valid?
          @emisionFuenteVan.save!
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_emision_van', emisionFuenteVan:@emisionFuenteVan,locals: {exito:true} }
          end
        else
          respond_to do |format|
            format.html { render partial: 'administradors/form_configuracion_emision_van', emisionFuenteVan:@emisionFuenteVan }
            format.json { render json: @emisionFuenteVan.errors, status: :unprocessable_entity }
          end
        end
    end
  end
  #
  # Metodo para
  #
  def saldopromocion
    saldopromocion_id = params[:id]
    if saldopromocion_id.nil?
      @saldopromocion = Saldopromocion.new
      @conductor.user = Saldop.new
      @action = 'create'
      # respond_to do |format|
      #   format.html #listaconductores.html.erb
      # end
    else
      @saldopromocion = Saldopromocion.find(user_id)
      @action = 'update'
      respond_to do |format|
        format.html {render partial: 'shared/administrador_detalleconductor', locals: { saldopromocion: @saldopromocion, aciton: @action }}
      end
    end
  end

  def administrador_detallesaldopromocion
    saldopromocion_id = params[:id]
    @saldopromocion = Saldopromocion.new
    if saldopromocion_id.nil?
      @action = 'create'
    else
      @saldopromocion = Saldopromocion.find(saldopromocion_id)
      @saldopromocion.medalla = Medalla.find(@saldopromocion.medalla)
      @action = 'update'
      respond_to do |format|
        format.html { render partial: 'shared/administrador_detallecliente', locals: { saldopromocion: @saldopromocion, aciton: @action }, layout:false}
      end
    end
  end

  #
  # Metodo para ver el perfil con la información de un cliente.
  #
  # def administrador_perfilcliente
  #   cliente_id = params[:cliente_id]
  #   @cliente = Cliente.new
  #   # if cliente_id.nil?
  #   #   redirect_to '/administrar_clientes'
  #   # else
  #     @cliente = Cliente.find(cliente_id)
  #     @cliente.user = User.find(@cliente.user_id)
  #     @action = 'update'
  #     respond_to do |format|
  #       format.html #{ render partial: 'shared/administrador_detallecliente', locals: { cliente: @cliente, aciton: @action }, layout:false}
  #       format.json
  #       format.js
  #     end
  #   # end
  # end

  def reporteretros
    @aspectos =aspectos
    @rutas=rutas
    @retrosjoin=Retroalimentacion.joins(:reservacion=>[{:viaje=>:ruta}])
    render 'show_reporte_retro'
  end

  def sugerencias
    @sugerencias = Sugerencia.all
    
  end

  def administrador_detallesugerencia
    sugerencia_id = params[:sugerencia_id]
    if sugerencia_id.nil?
      
      # respond_to do |format|
      #   format.html #listaconductores.html.erb
      # end
    else
      @sugerencia = Sugerencia.find(sugerencia_id)
      @paradas =@sugerencia.sugerenciaparadas.sort { |a, b| a.posicion <=> b.posicion }
      @origen = @paradas.first
      @destino = @paradas.last

      respond_to do |format|
        format.html {render partial: 'shared/administrador_detallesugerencia', locals: { sugerencia: @sugerencia, origen: @origen, destino: @destino, paradas: @paradas }}
      end
    end
  end

  def show_viajes
    @title = "Viajes"
    @ruta_id = params[:id]
    @ruta  = Ruta.find(@ruta_id)
    #@viajesproximos = Viaje.where("(estadoviaje_id= 1 or estadoviaje_id=2) and ruta_id= ?", ruta_id)
    #@viajesrealizados = Viaje.where("estadoviaje_id= 3 and ruta_id= ?", ruta_id)
    #@viajescancelados = Viaje.where("estadoviaje_id= 4")
  end


  def administrador_detalleviaje
    viaje_id = params[:viaje_id]
      @viaje = Viaje.find(viaje_id)
      @paradas = @viaje.ruta.paradas.order('posicion ASC')
      @origen = @paradas.first
      @destino = @paradas.last
      @disponibilidad = calcula_disponibilidad_viaje(@viaje)
      @pasajeros = calcula_pasajeros_viaje(@viaje)
      
      @tiempoParadas = []
      ruta_id = @viaje.ruta.id
      @paradas.each_with_index do |parada, i|
        if i == 0
          @tiempoParadas << 0
        elsif i<=@paradas.count
          parada_id = parada.id
          tiempo = Rutaparada.find_by_ruta_id_and_parada_id(ruta_id, parada_id).tiempo
          @tiempoParadas<< (@tiempoParadas[i-1]+tiempo.to_i)        
        end
      end


      respond_to do |format|
        format.html {render partial: 'shared/administrador_detalleviaje', locals: { viaje: @viaje, origen: @origen, destino: @destino, paradas: @paradas, tiempoParadas: @tiempoParadas, disponibilidad: @disponibilidad, pasajeros: @pasajeros }}
      end
  end#administrador_detalleviaje



  #
  # Metodo para actualizar la información de un administrador
  #
  def update
    paramsuser = OpenStruct.new params[:user]
    @administrador = User.new
    @administrador = User.find(paramsuser.id)
    mismoAdmin = false
    if @administrador.id != paramsuser.id
      mismoAdmin = true
    end
    if paramsuser.password.present?
        @administrador.attributes = {:name => paramsuser.name, :email => paramsuser.email,
                                     :fechaNacimiento => paramsuser.fechaNacimiento,
                                     :apellidoPaterno => paramsuser.apellidoPaterno,
                                     :apellidoMaterno => paramsuser.apellidoMaterno,
                                     :password => paramsuser.password,
                                     :password_confirmation => paramsuser.password_confirmation }
    else
        @administrador.attributes = {:name => paramsuser.name, :email => paramsuser.email,
                                     :fechaNacimiento => paramsuser.fechaNacimiento,
                                     :apellidoPaterno => paramsuser.apellidoPaterno,
                                     :apellidoMaterno => paramsuser.apellidoMaterno }
    end
    @action = 'update'
    if @administrador.valid?
      @administrador.save!
      # if mismoAdmin
      #   sign_in @administrador
      # end
      respond_to do |format|
        # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
        format.html { render partial: 'administradors/form_administrador', administrador:@administrador, locals: {exito:true}}
      end
    else
      respond_to do |format|
        # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
        format.html { render partial: 'administradors/form_administrador', administrador:@administrador }
        format.json { render json: @conductor.errors, status: :unprocessable_entity }
      end
    end
  end
  #
  # Metodo para crear administradores
  #
  def create
    paramsuser = OpenStruct.new params[:user]
    @administrador = User.new
    @administrador.attributes = {:name => paramsuser.name, :email => paramsuser.email,
                                 :fechaNacimiento => paramsuser.fechaNacimiento,
                                 :password => paramsuser.password,
                                 :password_confirmation => paramsuser.password_confirmation,
                                 :admin => true,
                                 :estatusUsuario => true}
    @action = 'create'
    if @administrador.valid?
      if @administrador.save!
        respond_to do |format|
          # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
          format.html { render partial: 'administradors/form_administrador', administrador:@conductor, locals: {exito:true}, create: true}
        end
      else
        respond_to do |format|
          # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
          format.html { render partial: 'administradors/form_administrador', administrador:@conductor, create: true }
          format.json { render json: @conductor.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
        format.html { render partial: 'administradors/form_administrador', administrador:@conductor, create: true }
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

    # Convertimos los valores para que puedan ser procesados por posgresql
    jtSorting = jtSorting.gsub(/(apellidoMaterno)/i, '"apellidoMaterno"')
    jtSorting = jtSorting.gsub(/(apellidoPaterno)/i, '"apellidoPaterno"')
    jtSorting = jtSorting.gsub(/(fechaNacimiento)/i, '"fechaNacimiento"')

    # Si el campo de busqueda tiene solo espacios en blanco.
    if jtTextoBusqueda.blank? || jtTextoBusqueda.to_s == ''
      @results = User.where("admin = 't'").order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    else
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = User.where("( name ILIKE :search OR
                             \"apellidoMaterno\" ILIKE :search OR
                             \"apellidoPaterno\" ILIKE :search OR
                               email ILIKE :search OR
                               to_char(\"fechaNacimiento\", 'MM/DD/YYYY') ILIKE :search
                              ) AND \"estatusUsuario\" = 't' AND admin = 't'",search: "%#{jtTextoBusqueda.strip}%").order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
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
    @administrador = User.find(params[:id])

    # Iniciamos la eliminación del registro, si no se elimina, almacenamos el resultado en un boleano.
    bolExito = true
    errMensaje = ''
    if @administrador.id != current_user.id
      begin
        @administrador.admin = false
        @administrador.save!
      rescue => e
        bolExito = false
        errMensaje = "No se pudo eliminar. Revise el error: #{e}"
      end
    else
      bolExito = false
      errMensaje = "No se puede eliminar a usted mismo."
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

  private
    def admin_user
      redirect_to(root_path) unless current_user.try(:admin?)

    end


end
