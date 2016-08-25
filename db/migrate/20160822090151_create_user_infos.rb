class CreateUserInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_infos do |t|
      t.jsonb :data
      t.integer :profile_id
      t.timestamps
    end
  end
end
