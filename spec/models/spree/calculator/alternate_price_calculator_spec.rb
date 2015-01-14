require 'spec_helper'

module Spree
	class Calculator
		describe AlternatePriceCalculator, :type => :model do
			original_price = 100
			alt_price = 25
			let(:categories) { FactoryGirl.create_list(:category, 2) }
			let(:line_item) { FactoryGirl.create(:line_item, price: original_price) }

			before do
				FactoryGirl.create :price, variant: line_item.variant, category: categories.first, amount: alt_price
			end

			context 'when valid' do
				context 'with category' do
					before { subject.preferred_category = categories.first.name }

					it 'uses alternate pricing' do
						expect(subject.compute(line_item)).to eq(original_price - alt_price)
					end

					context 'when multiple' do
						quantity = 2
						before { line_item.update_attributes(quantity: quantity) }

						it 'multiplies by quantity' do
							expect(subject.compute(line_item)).to eq(quantity * (original_price - alt_price))
						end
					end
				end

				context 'without category' do
					before { subject.preferred_category = categories.last.name }

					context 'without fallback' do
						before { subject.preferred_fallback_to_default_pricing = false }

						it 'has no price' do
							expect(subject.compute(line_item)).to be_nil
						end
					end

					context 'with fallback' do
						before { subject.preferred_fallback_to_default_pricing = true }

						it 'uses default pricing' do
							expect(subject.compute(line_item)).to eq(line_item.amount)
						end
					end
				end
			end

			context 'when invalid' do
				it 'should raise exception' do
					expect { subject.compute(line_item) }.to raise_exception
				end
			end
		end
	end
end
