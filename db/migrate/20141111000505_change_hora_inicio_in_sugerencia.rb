class ChangeHoraInicioInSugerencia < ActiveRecord::Migration
  def up
  	change_column :sugerencias, :hora_inicio, :datetime
  end

  def down
  end
end
