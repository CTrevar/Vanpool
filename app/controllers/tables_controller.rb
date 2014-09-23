class TablesController < ApplicationController
  def administradoresTableContainer
    respond_to do |format|
      format.json {
        page_size = params[:jtPageSize].to_i
        start_index = params[:jtStartIndex].to_i
        start_page = start_index / page_size + 1
        sort_by = params[:jtSorting].gsub('__', '.')
        @administradors_count = Administrador.all.size
        @administradors = Administrador.all.order(sort_by).paginate(:page => start_page, :per_page => page_size)
      }
      format.html {}
      format.js {}
    end
  end
end
