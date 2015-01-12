Spree::Price.class_eval do
	belongs_to :category, class_name: 'Spree::PriceCategory'
end
