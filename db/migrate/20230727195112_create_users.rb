class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :email
      t.string :token

      t.timestamps
    end
  end
end
