class Addkilometraje < ActiveRecord::Migration
def change
    add_column :clientes, :co2ahorrado, :decimal, default: 0
    add_column :clientes, :kilometros, :decimal, default: 0
  end
end
