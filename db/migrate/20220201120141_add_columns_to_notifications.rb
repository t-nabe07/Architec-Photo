class AddColumnsToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :visiter_id, :integer
    add_column :notifications, :visited_id, :integer
    add_column :notifications, :production_id, :integer
    add_column :notifications, :comment_id, :integer
    add_column :notifications, :action, :string
    add_column :notifications, :checked, :boolean, default: false, null: false
  end
end
