class TablesController < ApplicationController

def demo
	@cliente=obtener_cliente
  
  respond_to do |format|
    format.json {
      page_size = params[:jtPageSize].to_i
      start_index = params[:jtStartIndex].to_i
      start_page = start_index / page_size + 1
      sort_by = params[:jtSorting].gsub('__', '.')
      @nivels_count = Nivel.all.size()
      @nivels = Nivel.all
      paginate(:page => start_page, :per_page => page_size)
    }
    format.html {}
    format.js {}
  end
end

def obtener_cliente
  @cliente = Cliente.find_by_user_id(current_user.id)
end

end
