class Addestados < ActiveRecord::Migration
	def change
    add_column :medallas, :estado, :integer, default: 0
    add_column :medallas, :descripcion, :string
  end
end
