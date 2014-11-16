class ChangeRetro < ActiveRecord::Migration
  def up
    add_column :retroalimentacions, :tipocalificacion_id, :integer
  end

  def down
  end
end
