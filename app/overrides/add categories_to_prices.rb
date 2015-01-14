virtual_path = 'spree/admin/prices/_variant_prices'

# Add header for default
Deface::Override.new(virtual_path: virtual_path,
	name: 'add_default_headers',
	insert_after: 'h5',
	text: %q{
		<% if Spree::PriceCategory.all.any? %>
			<h6>&nbsp;</h6>
		<% end %>
	},
	original: '8139694f91be91576dccbb8949d605f677afb828'
)

# Append categories w/ header
Deface::Override.new(virtual_path: virtual_path,
	name: 'append_categories',
	insert_after: 'div.omega',
	text: %q{
	  <% categories = Spree::PriceCategory.all %>
	  <% categories.each do |category| %>
	    <div class="omega four columns">
				<h5>&nbsp;</h5>
	      <h6><%= category.name.titleize %></h6>
	      <% supported_currencies.each do |currency| %>
	        <% price = variant.price_in(currency.iso_code, category) %>
	        <div class="field">
	          <% tag_name = "vpc[#{variant.id}][#{currency.iso_code}][#{category.name}]" %>
	          <%= label_tag tag_name, currency.iso_code %>
	          <%= text_field_tag(tag_name, (price && price.price ? price.display_amount.money : '')) %>
	        </div>
	      <% end %>
	    </div>
	  <% end %>
	},
	original: '869cab3c38208e1276b94e81b604467e14fb5284'
)