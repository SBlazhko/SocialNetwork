class ChangeColumnUserInfos < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_infos, :data
    add_column :user_infos, :key, :string
    add_column :user_infos, :value, :string
    add_index :user_infos, :key
    add_index :user_infos, :value
  end
end
