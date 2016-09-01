class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.integer :profile_id
      t.string :token
      t.boolean :enabled, default: true
      t.string :platform
      t.timestamps
    end
  end
end
