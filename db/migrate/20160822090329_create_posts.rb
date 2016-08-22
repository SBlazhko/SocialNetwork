class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :access_level
      t.string :text
      t.integer :profile_id

      t.timestamps
    end
  end
end
