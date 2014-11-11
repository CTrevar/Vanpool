class ReservacionsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :retro]
  # GET /reservacions
  # GET /reservacions.json
  def index
    @reservacions = Reservacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservacions }
    end
  end

  # GET /reservacions/1
  # GET /reservacions/1.json
  def show
    @reservacion = Reservacion.find(params[:id])
    @current_cliente = obtener_cliente(current_user)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reservacion }
    end
  end

  # GET /reservacions/new
  # GET /reservacions/new.json
  def new
    @reservacion = Reservacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reservacion }
    end
  end

  # GET /reservacions/1/edit
  def edit
    @reservacion = Reservacion.find(params[:id])
  end

  # POST /reservacions
  # POST /reservacions.json
  def create
    @reservacion = Reservacion.new(params[:reservacion])

    respond_to do |format|
      if @reservacion.save
        format.html { redirect_to @reservacion, notice: 'Reservacion was successfully created.' }
        format.json { render json: @reservacion, status: :created, location: @reservacion }
      else
        format.html { render action: "new" }
        format.json { render json: @reservacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reservacions/1
  # PUT /reservacions/1.json
  def update
    @reservacion = Reservacion.find(params[:id])

    respond_to do |format|
      if @reservacion.update_attributes(params[:reservacion])
        format.html { redirect_to @reservacion, notice: 'Reservacion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reservacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservacions/1
  # DELETE /reservacions/1.json
  def destroy
    @reservacion = Reservacion.find(params[:id])
    @reservacion.destroy

    respond_to do |format|
      format.html { redirect_to reservacions_url }
      format.json { head :no_content }
    end
  end

  def retroalimentacion
    @title="Evalua el servicio"
    @current_cliente = obtener_cliente(current_user)
    @aspectos=aspectos
    @reservacion=params[:id]
    @reserva=Reservacion.find(@reservacion)
    render 'show_retro'
  end

  def create_retro
    id=params[:reservacion_id]
    aspectos.each do |aspecto|
      calificacion=params[:"#{aspecto.id}"]
      retro = Retroalimentacion.create(reservacion_id:id,aspecto_id:aspecto.id,calificacion:calificacion)
    end
    redirect_to :controller => 'clientes', :action => 'reservaciones'
  end

end
