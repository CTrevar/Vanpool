class CreateSugerencia < ActiveRecord::Migration
  def change
    create_table :sugerencias do |t|
      t.datetime :hora_inicio

      t.timestamps
    end
  end
end
