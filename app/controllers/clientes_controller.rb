class ClientesController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :dashboard, :profile, :obtener_cliente]

  # GET /clientes
  # GET /clientes.json
  def index
    @clientes = Cliente.all

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
    @cliente = Cliente.find(params[:id])
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
    #@users = User.paginate(page: params[:page])
    @cliente = obtener_cliente
  end


  # GET /clientes/1/profile
  def profile
    @title = "Perfil"
    @user = User.find(params[:id])

    ##revisar linea mala
    @cliente = Cliente.find(@user.id)
    
    if valida_ultimo_nivel==false then
      @mensaje="Solo te faltan #{calcula_puntos_siguiente_nivel} 
      para el nivel #{calcula_siguiente_nivel.nombre}" 
    else
      @mensaje=""
    end
    
    @co2 = calcula_co2
    @kilometros = 200
    @litros = 30

    @muro= @cliente.medallas

    render 'show_profile'
  end

  def obtener_cliente
    ##revisar linea mala
    @cliente = Cliente.find(current_user.id)
  end

  private
    def calcula_co2
      return(Cliente.find(@user.id).puntaje*196)/1000
    end

    def valida_ultimo_nivel
      if Nivel.find(@cliente.nivel.id).id==Nivel.last.id 
        return true
      else
        return false
      end
    end

    def calcula_siguiente_nivel
        return Nivel.find(@cliente.nivel.id+1)
    end
    
    def calcula_puntos_siguiente_nivel
      return calcula_siguiente_nivel.rangomaximo-Cliente.find(@user.id).puntaje
    end

end


