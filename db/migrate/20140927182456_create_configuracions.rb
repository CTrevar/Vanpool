class CreateConfiguracions < ActiveRecord::Migration
  def change
    create_table :configuracions do |t|
      t.string :nombre
      t.text :valor

      t.timestamps
    end
  end
end
