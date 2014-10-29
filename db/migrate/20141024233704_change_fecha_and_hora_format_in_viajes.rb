class ChangeFechaAndHoraFormatInViajes < ActiveRecord::Migration
  def up
  	change_column :viajes, :horainicio, :datetime
  	change_column :viajes, :fecha, :datetime
  end

  def down
  end
end
