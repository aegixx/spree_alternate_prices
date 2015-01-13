require 'spec_helper'

describe Spree::PriceCategory do

	cat_name = 'This is a Test'
	let(:category) { FactoryGirl.build :category, name: cat_name }

	describe '.name' do
		it 'validates name' do
			expect(category.valid?).to be_truthy
			category.name = nil
			expect(category.valid?).to be_falsey
		end

		it 'sanitizes name' do
			expect(category.read_attribute(:name)).to eq(cat_name.parameterize.underscore)
		end

		it 'titleizes name' do
			expect(category.name).to eq(cat_name.titleize)
		end
	end

end