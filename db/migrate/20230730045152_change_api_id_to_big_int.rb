class ChangeApiIdToBigInt < ActiveRecord::Migration[7.0]
  def up
    change_column :recipes, :api_id, :bigint, using: 'api_id::bigint'
  end

  def down
    change_column :recipes, :api_id, :string
  end
end
