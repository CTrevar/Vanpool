class CreateTipomedallas < ActiveRecord::Migration
  def change
    create_table :tipomedallas do |t|
    	t.string :nombre
      t.timestamps
    end
  end
end
