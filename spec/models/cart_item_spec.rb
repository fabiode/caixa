require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:product) { create :product }
  subject { CartItem.create product_id: product.id }

  describe 'associations' do
    it { is_expected.to belong_to :product }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :quantity }
    it { is_expected.to validate_presence_of :price_cents }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
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
        end.to raise_error PromotionalItemError,
                           "Promotional items cannot be destroyed by destroy. If you are sure what you're doing, use destroy_promotional! instead."
      end
    end

    describe '#destroy_promotional!' do
      it 'destroys item' do
        expect(subject.persisted?).to be_truthy
        subject.destroy_promotional!
        expect(subject.persisted?).to be_falsey
      end
    end
  end

  describe '#total_price' do
    before { allow(subject).to receive(:quantity).and_return(3) }
    it { expect(subject.total_price).to eq(subject.price * 3) }
  end
end
