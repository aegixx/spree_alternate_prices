virtual_path = 'spree/admin/prices/_variant_prices'

# Add header for default
Deface::Override.new(virtual_path: virtual_path,
	name: 'add_default_headers',
	insert_top: 'div.omega.two.columns',
	text: %q{
		<% if Spree::PriceCategory.all.any? %>
			<h6>&nbsp;</h6>
		<% end %>
	},
	original: '8cf3e1030e19fccf62ece564f672ac6a017fabb8'
)

# Wrap with row
Deface::Override.new(virtual_path: virtual_path,
	name: 'wrap_with_row',
	surround: 'h5~div',
	sequence: {after: 'add_default_headers'},
	text: %q{
		<div class="row">
			<%= render_original %>
		</div>
	},
	original: 'ec3098ea3d95d5dce1f61a45eec5e8a3e3d3ae4a'
)

# Append categories w/ header
Deface::Override.new(virtual_path: virtual_path,
	name: 'append_categories',
	insert_bottom: 'h5~div.row',
	sequence: {after: 'wrap_with_row'},
	text: %q{
	  <% categories = Spree::PriceCategory.all %>
	  <% categories.each do |category| %>
	    <div class="omega four columns">
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
	original: 'c2febadced83e60cc62a036c18ea31d16e950b3d'
)