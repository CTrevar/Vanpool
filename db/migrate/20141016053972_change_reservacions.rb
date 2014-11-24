class ChangeReservacions < ActiveRecord::Migration
def change
change_column :reservacions, :referenciapago_id, :string
end
end