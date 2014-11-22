class CreateLider < ActiveRecord::Migration
  def change
    create_table :liders do |t|
      t.integer :cliente_id
      t.integer :ruta_id
      t.integer :record
      t.boolean :estatus
    
      t.timestamps
    end
  end
end