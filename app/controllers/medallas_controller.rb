class MedallasController < ApplicationController
  before_filter :admin_user, only: [:index, :create , :update, :show, :new, :edit, :destroy], 
  except:[:jtable_list, :jtable_filterlist, :jtable_delete, :jtable_create, :jtable_update]
  
  # GET /medallas
  # GET /medallas.json
  def index
    #@user = User.new
    @medallas = Medalla.all
    #@cliente = obtener_cliente

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @medallas }
    end
  end

  # GET /medallas/1
  # GET /medallas/1.json
  def show
      @user = User.new
      @cliente = obtener_cliente
    @medalla = Medalla.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @medalla }
    end
  end

  # GET /medallas/new
  # GET /medallas/new.json
  def new
    @user = User.new
    @medalla = Medalla.new
    @cliente = obtener_cliente

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medalla }
    end
  end

  # GET /medallas/1/edit
  def edit
    @medalla = Medalla.find(params[:id])
  end

  # POST /medallas
  # POST /medallas.json
  #def create
  #  @medalla = Medalla.new(params[:medalla])

  # respond_to do |format|
  #    if @medalla.save
  #      format.html { redirect_to @medalla, notice: 'Medalla was successfully created.' }
  #      format.json { render json: @medalla, status: :created, location: @medalla }
  #    else
  #      format.html { render action: "new" }
  #      format.json { render json: @medalla.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # PUT /medallas/1
  # PUT /medallas/1.json
  #def update
  #  @medalla = Medalla.find(params[:id])

  #  respond_to do |format|
  #    if @medalla.update_attributes(params[:medalla])
  #      format.html { redirect_to @medalla, notice: 'Medalla was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @medalla.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /medallas/1
  # DELETE /medallas/1.json
  def destroy
    @medalla = Medalla.find(params[:id])
    @medalla.destroy

    respond_to do |format|
      format.html { redirect_to medallas_url }
      format.json { head :no_content }
    end
  end

   # Método para crear un conductor a través de la forma del panel lateral.
  # POST /conductors
  # POST /conductors.json
  def create
    paramsmedalla = OpenStruct.new params[:medalla]
    #paramsuser = OpenStruct.new paramsconductor.user
    @medalla = Medalla.new
    #user = User.new
    @medalla.attributes = {:nombre => paramsmedalla.nombre, 
                          :puntos => paramsmedalla.puntos, 
                          :tipomedalla_id => paramsmedalla.tipomedalla_id, 
                          :imagen => paramsmedalla.imagen, 
                          :estatus => paramsmedalla.estatus, 
                          :descripcion => paramsmedalla.descripcion
                       } 
    #@conductor.user = user
    @action = 'create'
    if @medalla.valid?
        if @medalla.save!
          respond_to do |format|
            # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
            format.html { render partial: 'administradors/form_medalla', medalla:@medalla, locals: {exito:true}, create: true}
          end
        else
          respond_to do |format|
            # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
            format.html { render partial: 'administradors/form_medalla', medalla:@medalla, create: true }
            format.json { render json: @medalla.errors, status: :unprocessable_entity }
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

  # Método para actualizar los datos de un conductor a través dela forma del panel lateral.
  def update
    paramsmedalla = OpenStruct.new params[:medalla]
    @medalla = Medalla.find(paramsmedalla.id)
    @medalla.attributes = {:nombre => paramsmedalla.nombre, 
                          :puntos => paramsmedalla.puntos, 
                          :tipomedalla_id => paramsmedalla.tipomedalla_id, 
                          :imagen => paramsmedalla.imagen, 
                          :estatus => paramsmedalla.estatus, 
                          :descripcion => paramsmedalla.descripcion
                       } 
    @action = 'update'
    if @medalla.valid?
      @medalla.save!
      respond_to do |format|
        # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
        format.html { render partial: 'administradors/form_medalla', medalla:@medalla, locals: {exito:true}}
      end
    else
      respond_to do |format|
        # format.js { render :js => "window.location = '#{forma_detalle_conductor @conductor}'" }
        format.html { render partial: 'administradors/form_conductor', medalla:@medalla }
        format.json { render json: @medalla.errors, status: :unprocessable_entity }
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

    @results = Medalla.order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => Medalla.count,
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
      @results = Medalla.select('*').where("estatus = 't'").joins(:tipomedalla).select('medallas.id as medalla_id,medallas.tipomedalla_id as tipomedalla_id, tipomedallas.nombre as nombre_tipomedalla, medallas.nombre as nombre_medalla').order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)

    else
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = Medalla.select('*').where("(LOWER(nombre) LIKE '%#{jtTextoBusqueda.downcase}%') 
        AND estatus = 't'").joins(:tipomedalla).select('medallas.tipomedalla_id as tipomedalla_id, tipomedallas.nombre as nombre_tipomedalla, medallas.nombre as nombre_medalla').order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
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
    medalla = Medalla.find_by_medalla_id(params[:id])

    # Iniciamos la eliminación del registro, si no se elimina, almacenamos el resultado en un boleano.
    bolExito = true
    errMensaje = ''
    begin
      medalla.estatus = false
      medalla.save!
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
   
    nombre = params[:nombre]
    puntos = params[:puntos]
    tipomedalla_id = params[:tipomedalla_id]
    imagen = params[:imagen]
    descripcion = params[:descripcion]
    

    # Iniciamos la creación del registro, si no se crea, almacenamos el resultado en un boleano.
    bolexito = false
    errmensaje = ""
    begin
      new = Medalla.new(:nombre => nombre, :puntos => puntos,
                              :tipomedalla_id => tipomedalla_id, :imagen => imagen,
                              :descripcion => descripcion)
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
    # medalla
     
    id = params[:id]
    nombre = params[:nombre]
    puntos = params[:puntos]
    tipomedalla_id = params[:tipomedalla_id]
    imagen = params[:imagen]
    descripcion = params[:descripcion]
    estatus = params[:estatus]


    # Iniciamos la actualización del registro, si no se acutaliza, almacenamos el resultado en un boleano.
    bolexito = false
    errmensaje = ""
    # begin
      actualrowmedalla = Medalla.find(id)
      if actualrowmedalla.present?
        actualrowmedalla.attributes = { :nombre => nombre, :puntos => puntos,
         :tipomedalla_id=>tipomedalla_id, :imagen=>imagen,
          :descripcion=>descripcion, :estatus=>estatus}
      end

      if actualrowmedalla.valid?
        actualrowconductor = actualrowconductor.save!
        bolexito = true
      else
        errmensaje = "No se pudo actualizar.</br>"
        errmensaje += actualrowmedalla.errors.messages.to_s
      end
    actualrow = Medalla.select('*').where("id = #{id}")
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
    def admin_user
      redirect_to(root_path) unless current_user.try(:admin?)

    end

end
