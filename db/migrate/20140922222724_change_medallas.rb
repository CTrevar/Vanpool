class ChangeMedallas < ActiveRecord::Migration
change_table :medallas do |t|
  t.rename :tipomedallas_id, :tipomedalla_id
end
end
