class CreateSugerencia < ActiveRecord::Migration
  def change
    create_table :sugerencias do |t|
      t.string :hora_inicio

      t.timestamps
    end
  end
end
