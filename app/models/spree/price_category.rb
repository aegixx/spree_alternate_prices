class Spree::PriceCategory < ActiveRecord::Base
	validates :name, presence: true, format: { with: /[a-z0-9 ]*/i , message: 'must be alphanumeric only' }

	def name=(value)
		write_attribute(:name, value.try(:parameterize).try(:underscore))
	end
end
