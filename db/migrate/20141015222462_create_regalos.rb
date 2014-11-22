class CreateRegalos < ActiveRecord::Migration
  def change
    create_table :regalos do |t|
      t.string  :nombre
      t.string  :descripcion
      t.integer :perfil_id
      t.integer  :medalla_id
      t.boolean :estatus, :default => true
    
      t.timestamps
    end
  end
end