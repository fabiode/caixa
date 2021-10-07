require 'rails_helper'

RSpec.describe 'CartItems', type: :request do
  let(:cart) { create :cart }
  let(:product) { create :product }

  describe 'POST create' do
    it 'returns 200 with resource' do
      post cart_items_path(cart), params: { product_id: product.id }
      expect(response.body).to match 'id'
      expect(response.status).to eq 200
    end
  end

  describe 'PUT update' do
    before { cart.add_product product }
    let(:cart_item) { cart.cart_items.first }

    it 'returns 200 with resource' do
      put cart_item_path(cart, cart_item), params: { cart_item: { quantity: 3 } }
      expect(response.body).to match 'id'
      expect(response.status).to eq 200
    end
  end

  describe 'DELETE destroy' do
    before { cart.add_product product }
    let(:cart_item) { cart.cart_items.first }

    it 'returns 200 with resource' do
      delete cart_item_path(cart, cart_item)
      expect(response.body).to match 'id'
      expect(response.status).to eq 200
    end
  end
end
