class RemoveColumnFromTokens < ActiveRecord::Migration[5.0]
  def change
  	remove_column :tokens, :token
  end
end
