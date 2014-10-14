class AddHoraInicioToRutas < ActiveRecord::Migration
  def change
    add_column :ruta, :hora_inicio, :string
  end
end
