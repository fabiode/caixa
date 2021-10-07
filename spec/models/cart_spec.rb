require 'rails_helper'

RSpec.describe Cart, type: :model do
  subject { create :cart }
  describe 'associations' do
    it { is_expected.to have_many :cart_items }
    it { is_expected.to have_many(:products).through(:cart_items) }
    it { is_expected.to have_and_belong_to_many :promotion_rules }
  end

  describe '#add_product' do
    let(:product) { create :product }
    it { is_expected.to respond_to :add_product }

    context 'argument is not a product' do
      let(:product) { Object.new }

      it 'raises error' do
        expect { subject.add_product(product) }.to raise_error ArgumentError, 'must be an Product'
      end
    end

    context 'when the product is not added yet' do
      it 'creates a CartItem' do
        expect { subject.add_product(product) }.to change { CartItem.count }.by 1
      end
    end

    context 'when the product is already in the cart' do
      before { subject.add_product(product) }

      it 'raises quantity of the cart item' do
        expect { subject.add_product(product) }.to_not(change { CartItem.count })
        expect { subject.add_product(product) }.to change { subject.cart_items.first.quantity }.by 1
      end
    end
  end
end
