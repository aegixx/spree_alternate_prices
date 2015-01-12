class Spree::PriceCategory < ActiveRecord::Base
	validates :name, presence: true, format: { with: /[a-z0-9 ]*/i , message: 'must be alphanumeric only' }
	before_validation -> {
		self.name = self.name.parameterize.underscore
	}
end
