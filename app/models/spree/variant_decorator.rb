Spree::Variant.class_eval do

	has_one :default_price,
	-> { where(currency: Spree::Config[:currency], category_id: nil) },
		class_name: 'Spree::Price',
		dependent: :destroy

	has_many :prices,
	-> { where(category_id: nil) },
		class_name: 'Spree::Price',
		dependent: :destroy,
		inverse_of: :variant do
		def all_categories
			unscope(where: :category_id)
		end
		def with_category(category)
			rewhere(category_id: category.id)
		end
	end

	alias_method :old_price_in, :price_in
	def price_in(currency, category=nil)
		if category
			prices.with_category(category).find_by(currency: currency) || Spree::Price.new(variant_id: self.id, currency: currency, category: category)
		else
			old_price_in(currency)
		end
	end

	alias_method :old_amount_in, :amount_in
	def amount_in(currency, category=nil)
		price_in(currency, category).try(:amount)
	end

end
