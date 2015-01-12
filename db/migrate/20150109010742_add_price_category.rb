class AddPriceCategory < ActiveRecord::Migration
	def change
		create_table 'spree_price_categories' do |t|
			t.string :name, null: false
		end
	end
end
