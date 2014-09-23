class AdministradorsController < ApplicationController
  # GET /administradors
  # GET /administradors.json
  def index
    @administradors = Administrador.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @administradors }
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

end
