class RemoveHeirsUsers < ActiveRecord::Migration
  def up
  	remove_column :users, :heir_id
  	remove_column :users, :heir_type
  end

  def down
  end
end
