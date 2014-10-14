class AddDetailsToParadas < ActiveRecord::Migration
  def change
    add_column :paradas, :posicion, :integer
    add_column :paradas, :tiempo, :float
    add_column :paradas, :distancia, :float
  end
end
