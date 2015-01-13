require 'spec_helper'

module Spree
	module Admin
		RSpec.describe PriceCategoriesController, type: :controller do
			stub_authorization!

			describe '#index' do
				subject { spree_get :index }
				before { subject }

				let!(:categories) { FactoryGirl.create_list(:category, 2) }

				it 'loads categories' do
					expect(response.status).to be(200)
					expect(response).to render_template(:index)
					expect(assigns(:collection)).to match_array categories
				end
			end

			describe '#new' do

				subject { spree_get :new }
				before { subject }

				it 'creates a new category' do
					expect(assigns(:object)).to_not be_persisted
				end

			end

			describe '#edit' do
				let!(:category) { FactoryGirl.create(:category) }

				subject { spree_get :edit, {id: category.to_param} }
				before { subject }

				it 'loads the category' do
					expect(assigns(:object)).to eq category
				end
			end

			describe '#update' do

				let!(:category) { FactoryGirl.create(:category) }

				subject { spree_put :update, category_return_params }

				context 'valid category' do
					let!(:category_return_params) do
						{
							id: category.to_param,
							price_category: {
								name: 'New Name'
							}
						}
					end

					it 'updates category' do
						expect { subject }.to change { category.reload.name	}.from(category.name).to(category_return_params[:price_category][:name])
					end

					it 'redirects to the index page' do
						subject
						expect(response).to redirect_to(spree.admin_price_categories_path)
					end
				end

				context 'invalid category' do
					let!(:category_return_params) do
						{
							id: category.to_param,
							price_category: {
								name: ''
							}
						}
					end

					it 'does not update category' do
						expect { subject }.to_not change { category.reload.name }
					end

					it 'renders the edit page' do
						subject
						expect(response).to render_template(:edit)
						expect(assigns(:object)).to match(category)
					end
				end
			end

			describe '#create' do

				subject { spree_post :create, category_return_params }

				context 'valid category' do
					let!(:category_return_params) do
						{
							price_category: {
								name: 'New Name'
							}
						}
					end

					it 'creates a category' do
						expect { subject }.to change { Spree::PriceCategory.count }.by(1)
					end

					it 'redirects to the index page' do
						subject
						expect(response).to redirect_to(spree.admin_price_categories_path)
					end
				end

				context 'invalid category' do
					let!(:category_return_params) do
						{
							price_category: {
								name: ''
							}
						}
					end

					it 'does not create a category' do
						expect { subject }.to_not change { Spree::PriceCategory.count }
					end

					it 'renders the new page' do
						subject
						expect(response).to render_template(:new)
					end
				end
			end
		end
	end
end