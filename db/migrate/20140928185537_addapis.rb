class Addapis < ActiveRecord::Migration
	def change
    add_column :clientes, :facebook_id, :string
    add_column :clientes, :openpay_id, :string
  end
end
