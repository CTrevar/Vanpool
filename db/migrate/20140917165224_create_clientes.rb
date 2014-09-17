class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.integer :puntaje
      t.integer :nivel

      t.timestamps
    end
  end
end
