class AddAccssesLevelToUserInfos < ActiveRecord::Migration[5.0]
  def change
    add_column :user_infos, :access_level, :integer
    add_index :user_infos, :access_level
  end
end
