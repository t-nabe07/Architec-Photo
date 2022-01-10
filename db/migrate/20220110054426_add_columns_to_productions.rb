class AddColumnsToProductions < ActiveRecord::Migration[5.2]
  def change
    add_column :productions, :customer_id, :integer
    add_column :productions, :title, :string
    add_column :productions, :introduction, :text
  end
end
