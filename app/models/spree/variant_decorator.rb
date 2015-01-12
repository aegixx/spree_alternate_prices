Spree::Variant.class_eval do

	alias_method :old_price_in, :price_in
	def price_in(currency, category=nil)
		if category
			price = Spree::Price.unscoped.where(variant: self, currency: currency, category: category).first
			price || Spree::Price.new(variant_id: self.id, currency: currency, category: category)
		else
			old_price_in(currency)
		end
	end

	alias_method :old_amount_in, :amount_in
	def amount_in(currency, category=nil)
		price_in(currency, category).try(:amount)
	end

end
