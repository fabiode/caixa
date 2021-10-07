require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let!(:product) { create :product }
  before { product.promotion_rules << create(:buy_one_get_one) }

  describe 'GET /index' do
    it 'returns 200 with collection' do
      get '/products.json'
      expect(response.body).to_not be_nil
      expect(response.status).to eq 200
    end
  end
end
