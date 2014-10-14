class RemoveFieldkilometraje < ActiveRecord::Migration
  def change
  	remove_column :clientes, :kilometraje
  	remove_column :clientes, :kilometros
  end

end
