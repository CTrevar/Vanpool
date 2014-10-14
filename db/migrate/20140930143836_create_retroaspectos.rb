class CreateRetroaspectos < ActiveRecord::Migration
  def change
    create_table :retroaspectos do |t|
      t.string :nombre
      t.boolean :estatus

      t.timestamps
    end
  end
end
