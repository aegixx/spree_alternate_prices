class Spree::PriceCategory < ActiveRecord::Base
	validates :name, presence: true, format: { with: /[a-z0-9 ]*/i , message: 'must be alphanumeric only' }

	def name=(value)
		write_attribute(:name, self.class.sanitize(value))
	end

	def name
		read_attribute(:name).try(:titleize)
	end

	def self.sanitize(value)
		value.try(:parameterize).try(:underscore)
	end

end
