class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.integer :puntaje, :default => 0
      t.integer :nivel_id, :default => 1
      t.integer :user_id
      t.integer :perfil_id
      t.float :kilometros, :default => 0.0
      t.float :emisionco2, :default => 0.0
      t.string :openpay_id
      t.boolean :estatus, :default =>true

      t.timestamps
    end
  end
end
