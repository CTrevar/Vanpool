class Addco2 < ActiveRecord::Migration
	def change
    add_column :clientes, :co2, :integer, default: 0
  end
end
