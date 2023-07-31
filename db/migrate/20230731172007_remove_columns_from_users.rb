class RemoveColumnsFromUsers < ActiveRecord::Migration[7.0]
  def up 
    remove_column :users, :name
    remove_column :users, :email
  end

  def down
    add_column :users, :name, :string
    add_column :users, :email, :string
  end
end
