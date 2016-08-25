class CreateTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens do |t|
      t.integer :profile_id
      t.string :token, unique: true

      t.timestamps
    end
  end
end
