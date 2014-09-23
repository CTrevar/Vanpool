class CreateNivels < ActiveRecord::Migration
  def change
    create_table :nivels do |t|
      t.string :nombre
      t.integer :rangomaximo
      t.boolean :estatus

      t.timestamps
    end
  end
end
