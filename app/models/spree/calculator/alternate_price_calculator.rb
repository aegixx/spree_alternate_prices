module Spree
	class Calculator::AlternatePriceCalculator < Spree::Calculator
		preference :fallback_to_default_pricing, :boolean, default: true
		preference :category, :price_category, :string

		def self.description
			Spree.t(:price_category_calculator_description)
		end

		def compute(object=nil)
			category = PriceCategory.find_by(name: PriceCategory.sanitize(preferred_category))
			raise InvalidCategoryError, "Please provide a valid category for alternate pricing, '#{preferred_category}' was provided." unless category
			updated_price = object.variant.price_in(object.currency, category)
			if updated_price.new_record? # Non-committed price
				preferred_fallback_to_default_pricing ? object.price : nil
			else
				updated_price.price
			end
		end
	end
end
