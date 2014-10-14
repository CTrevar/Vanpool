class AddHoraInicioToRutas < ActiveRecord::Migration
  def change
    add_column :rutas, :hora_inicio, :string
  end
end
