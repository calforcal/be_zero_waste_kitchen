class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :instructions, array: true, default: []
      t.string :image_url
      t.float :api_rating
      t.integer :cook_time
      t.boolean :public_status
      t.string :source_name
      t.string :source_url

      t.timestamps
    end
  end
end
