require 'spec_helper'

describe Spree::Variant do

	let(:category) { FactoryGirl.create :category }
	let(:variant) { FactoryGirl.create :variant }

	currency = 'TWD'

	before do
		# Add a price to the variant for this category
		FactoryGirl.create :price, variant: variant, category: category

		# Add an alternate currency price
		@other_currency_price = FactoryGirl.create :price, variant: variant, currency: currency
		@other_currency_price_with_category = FactoryGirl.create :price, variant: variant, currency: currency, category: category
	end

	describe '#default_price' do
		it 'defaults to no category' do
			expect(variant.default_price.category_id).to be_nil
		end
	end

	describe '#prices' do
		it 'ignores categories by default' do
			rel = variant.prices
			expect(rel.count).to eq(2)
			expect(rel.collect(&:category_id).compact).to be_empty
		end

		describe '#with_category' do
			it 'matches only prices with category' do
				rel = variant.prices.with_category(category).where(currency: currency)
				expect(rel.count).to eq(1)
				expect(rel.collect(&:category_id).compact.uniq).to eq([category.id])
			end
		end
	end

	describe '#price_in' do
		it 'works as originally intended' do
			expect(variant.price_in(currency).id).to be(@other_currency_price.id)
		end

		it 'accepts category' do
			expect(variant.price_in(currency, category).id).to be(@other_currency_price_with_category.id)
		end
	end

end