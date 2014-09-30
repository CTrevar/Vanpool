class CreateReportes < ActiveRecord::Migration
  def change
    create_table :reportes do |t|
      t.integer :cliente_id
      t.string :descripcion
      t.boolean :estatus

      t.timestamps
    end
  end
end
