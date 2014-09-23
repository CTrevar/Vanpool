class ChangeClientesNivel < ActiveRecord::Migration
change_table :clientes do |t|
  t.rename :nivel, :nivel_id
end
end
