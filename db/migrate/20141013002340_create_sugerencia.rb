class CreateSugerencia < ActiveRecord::Migration
  def change
    create_table :sugerencia do |t|
      t.string :hora_inicio

      t.timestamps
    end
  end
end
