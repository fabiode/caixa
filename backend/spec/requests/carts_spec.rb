require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  let(:cart) { create :cart }
  describe 'GET show' do
    it 'returns 200 with resource' do
      get cart_path(cart)
      expect(response.body).to match 'id'
      expect(response.status).to eq 200
    end
  end
end
