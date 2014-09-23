class DropMedallas < ActiveRecord::Migration
  def up
  	drop_table :medallas
  	drop_table :tipomedallas
  end

  def down
  end
end
