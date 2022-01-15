class RemoveProfileImageIdFromCustomers < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :profile_image_id, :string
  end
end
