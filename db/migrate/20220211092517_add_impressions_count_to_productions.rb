class AddImpressionsCountToProductions < ActiveRecord::Migration[5.2]
  def change
    add_column :productions, :impressions_count, :integer, default: 0
  end
end
