class CreateRuta < ActiveRecord::Migration
  def change
    create_table :rutas do |t|
      t.integer :conductor_id
      t.integer :van_id
      t.string :nombre
      t.decimal :precio
      t.boolean :estatus
      t.integer :zona_id

      t.timestamps
    end
  end
end