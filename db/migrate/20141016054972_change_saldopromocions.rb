class ChangeSaldopromocions < ActiveRecord::Migration
def change
change_column :saldopromocions, :medalla_id, 'integer USING CAST(medalla_id AS integer)'
end
end
