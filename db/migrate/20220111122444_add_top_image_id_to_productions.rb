class AddTopImageIdToProductions < ActiveRecord::Migration[5.2]
  def change
    add_column :productions, :top_image_id, :string
  end
end
