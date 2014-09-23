class MedallasController < ApplicationController
  # GET /medallas
  # GET /medallas.json
  def index
      @user = User.new
    @medallas = Medalla.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @medallas }
    end
  end

  # GET /medallas/1
  # GET /medallas/1.json
  def show
      @user = User.new
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
  def create
    @medalla = Medalla.new(params[:medalla])

    respond_to do |format|
      if @medalla.save
        format.html { redirect_to @medalla, notice: 'Medalla was successfully created.' }
        format.json { render json: @medalla, status: :created, location: @medalla }
      else
        format.html { render action: "new" }
        format.json { render json: @medalla.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /medallas/1
  # PUT /medallas/1.json
  def update
    @medalla = Medalla.find(params[:id])

    respond_to do |format|
      if @medalla.update_attributes(params[:medalla])
        format.html { redirect_to @medalla, notice: 'Medalla was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @medalla.errors, status: :unprocessable_entity }
      end
    end
  end

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
end
