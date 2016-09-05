class ChangeColumnInDevises < ActiveRecord::Migration[5.0]
  def change
    remove_column :devices, :platform
    add_column :devices, :platform, :integer
    add_index :devices, :profile_id
  end
end
