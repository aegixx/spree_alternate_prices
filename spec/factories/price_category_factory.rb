FactoryGirl.define do
	factory :price_category, aliases: [:category], class: Spree::PriceCategory do
		sequence(:name) { |n| "category#{n}" }
	end
end
