class CreateTipocalificacion < ActiveRecord::Migration
  def change
    create_table :tipocalificacions do |t|
      t.string :nombre	

      t.timestamps
    end
  end
end