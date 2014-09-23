class CreateMedallas < ActiveRecord::Migration
  def change
    create_table :medallas do |t|
      t.integer :tipomedallas_id
      t.string  :nombre
      t.integer :puntos
      t.string  :imagen
      t.boolean :estatus
      t.timestamps
    end
  end
end
