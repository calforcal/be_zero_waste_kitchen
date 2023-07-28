class RemoveTokenFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :token
  end
end
