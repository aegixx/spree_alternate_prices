module Spree
  module Admin
    class PriceCategoriesController < ResourceController

      def collection
        super.order(:name)
      end

    end
  end
end