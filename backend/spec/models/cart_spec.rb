require 'rails_helper'

RSpec.describe Cart, type: :model do
  subject { create :cart }
  let(:product) { create :product }

  describe 'associations' do
    it { is_expected.to have_many :cart_items }
    it { is_expected.to have_many(:products).through(:cart_items) }
    it { is_expected.to have_and_belong_to_many :promotion_rules }
  end

  describe '#add_product' do
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
      before { subject.cart_items.create(product: product) }

      it 'raises quantity of the cart item' do
        expect { subject.add_product(product) }.to change { subject.cart_items.first.quantity }.by 1
      end
    end
  end

  describe '#recalculate_total_price' do
    let(:other_product) { create :product, :coffee }
    let(:final_price) { other_product.price + product.price }
    before do
      subject.add_product product
      subject.add_product other_product
    end

    it 'sets total price based on each cart_items total_price' do
      expect(subject.total_price).to eq final_price
    end
  end
end
