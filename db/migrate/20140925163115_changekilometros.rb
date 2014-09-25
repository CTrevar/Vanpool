class addkilometros < ActiveRecord::Migration
def change
    add_column :clientes, :kilometraje, :integer, default: 0
  end
end
