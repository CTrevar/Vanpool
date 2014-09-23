class AddColumnsCliente < ActiveRecord::Migration
def change
    add_column :clientes, :user_id, :integer
    add_column :clientes, :nivel_id, :integer
  end
end
