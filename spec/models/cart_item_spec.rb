require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:product) { create :product }
  subject { CartItem.create product_id: product.id }

  describe 'associations' do
    it { is_expected.to belong_to :product }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
    it { is_expected.to validate_presence_of :quantity }
    it { is_expected.to validate_presence_of :price_cents }
    it { is_expected.to validate_presence_of :product }

    context 'not promotional' do
      it 'has same price as product' do
        expect(subject.price).to eq product.price
      end
    end
  end

  context 'promotional' do
    subject { CartItem.create promotional: true, product: product }

    describe '#destroy' do
      it 'raises cannot be destroyed' do
        expect do
          subject.destroy
        end.to raise_error PromotionalItemError, 'Promotional items cannot be destroyed by itself'
      end
    end
  end
end
