class CreatePais < ActiveRecord::Migration
  def change
    create_table :pais do |t|
      t.string :clave, :limit => 45
      t.string :nombre, :limit => 100
      t.string :divisa, :limit => 10
      t.boolean :estatus

      t.timestamps
    end
  end
end
