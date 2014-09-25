class CreateEstadotipos < ActiveRecord::Migration
  def change
    create_table :estadotipos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
