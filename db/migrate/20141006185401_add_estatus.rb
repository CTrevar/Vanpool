class AddEstatus < ActiveRecord::Migration
  def up
    add_column :clientes, :estatus, :boolean, default:true
  end

  def down
  end
end
