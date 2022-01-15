class RemoveImageIdFromProductions < ActiveRecord::Migration[5.2]
  def change
    remove_column :productions, :image_id, :string
  end
end
