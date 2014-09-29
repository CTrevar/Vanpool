class CreateParadas < ActiveRecord::Migration
  def change
    create_table :paradas do |t|
      t.string :nombre, :limit => 100
      t.float :longitud
      t.float :latitud
      t.boolean :estatus

      t.timestamps
    end
  end
end
