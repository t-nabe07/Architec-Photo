class RemoveTopImageIdFromProductions < ActiveRecord::Migration[5.2]
  def change
    remove_column :productions, :top_image_id, :string
  end
end
