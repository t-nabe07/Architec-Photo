class AddColumnsToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :last_name, :string
    add_column :customers, :first_name, :string
    add_column :customers, :last_name_kana, :string
    add_column :customers, :first_name_kana, :string
    add_column :customers, :introduction, :text
    add_column :customers, :college_name, :string
    add_column :customers, :specialty_study, :string
    add_column :customers, :is_deleted, :boolean
  end
end
