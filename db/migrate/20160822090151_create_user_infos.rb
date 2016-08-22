class CreateUserInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_infos do |t|
      t.string :key
      t.string :value
      t.integer :access_level
      t.integer :profile_id

      t.timestamps
    end
  end
end
