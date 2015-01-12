class AddCategoryToSpreePrice < ActiveRecord::Migration
  def change
    add_column :spree_prices, :category_id, :integer
  end
end
