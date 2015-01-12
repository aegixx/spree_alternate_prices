Spree::Admin::PricesController.class_eval do
	before_filter :process_category_prices, only: :create

	protected

	def process_category_prices
		params[:vpc].each do |variant_id, prices|
			variant = Spree::Variant.find(variant_id)
			if variant
				supported_currencies.each do |currency|
					Spree::PriceCategory.all.each do |category|
						price = variant.price_in(currency.iso_code, category)
						price.price = new_price = prices[currency.iso_code].blank? || prices[currency.iso_code][category.name].blank? ? nil : prices[currency.iso_code][category.name]
						price.save! if price.new_record? && new_price || !price.new_record? && price.changed?
					end
				end
			end
		end if params[:vpc]

	end
end
