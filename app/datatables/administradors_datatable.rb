class AdministradorsDatatable
  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Administrador.count,
        iTotalDisplayRecords: administradors.total_entries,
        aaData: data
    }
  end

  private
    def data
      administradors.map do |administrador|
        [
            link_to(administrador.Nombreusuario, administrador),
            h(administrador.Emailusuario),
            h(administrador.Idtipousuario),
            h(administrador.Facebookidusuario),
            h(administrador.Nombrepilausuario),
            h(administrador.Apellidopaterno),
            h(administrador.Apellidomaterno),
            h(administrador.Fechanacimiento.strftime("%B %e, %Y")),
            h(administrador.Estatususuario)
        ]
      end
    end
    def administradors
      administradors ||= fetch_administradors
    end

    def fetch_administradors
      administradors = Administrador.order("#{sort_column} #{sort_direction}")
      administradors = administradors.page(page).per_page(per_page)
      if params[:sSearch].present?
        administradors = administradors.where("Nombreusuario like :search or Nombrepilausuario like :search", search: "%#{params[:sSearch]}%")
      end
      administradors
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[Nombreusuario Emailusuario Idtipousuario Facebookidusuario Nombrepilausuario Apellidopaterno Apellidomaterno Fechanacimiento Estatususuario]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end
end