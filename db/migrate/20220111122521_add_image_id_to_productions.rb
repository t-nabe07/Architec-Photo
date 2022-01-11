class AddImageIdToProductions < ActiveRecord::Migration[5.2]
  def change
    add_column :productions, :image_id, :string
  end
end
