class VansController < ApplicationController
	def new
		@van = Van.new
	end

	def create
		@van = Van.new(params[:van])
		@van.estatus= true
		@van.activa = true

		@van.save

		if @van.save
			redirect_to @van
		else
			render 'new'
		end
		
		
	end

	def show
		@van = Van.find(params[:id])
	end

	def index
		@vans = Van.all
	end

	def destroy
		@van = Van.find (params[:id])
		@van.destroy
		redirect_to vans_path
	end

	def edit
		@van = Van.find(params[:id])
	end

	def update
		@van = Van.find(params[:id])
		if @van.update_attributes(params[:van])
			redirect_to @van
		else
			render 'edit'
		end
	end



# ///////////////////////////////////////////////////////
  # Método para listar SIN buscar los registros de la BD
  #
  def jtable_list

    jtSorting = params[:jtSorting]
    jtStartIndex = params[:jtStartIndex]
    jtPageSize = params[:jtPageSize]
    jtStartPage = jtStartIndex.to_i / jtPageSize.to_i + 1

    @results = Van.order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => Van.count,
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
      @results = Van.order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    else
      # Si contiene algo más realiza la búsqueda en todos los atributos de la tabla.
      @results = Van.where( "LOWER(placa) LIKE '%#{jtTextoBusqueda.downcase}%' OR LOWER(modelo) LIKE '%#{jtTextoBusqueda.downcase}%' OR
                                       LOWER(capacidad) LIKE '%#{jtTextoBusqueda.downcase}%'"
      ).order(jtSorting).paginate(page:jtStartPage,per_page:jtPageSize)
    end
    respond_to do |format|
      # Regresamos el resultado de la operación a la jTable
      jTableResult = {:Result => "OK",
                      :TotalRecordCount => Van.count,
                      :Records => @results
                      }
      format.json { render json: jTableResult}
      format.html
      format.js
    end
  

  end

end