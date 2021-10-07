require 'rails_helper'

RSpec.describe PromotionRules::BuyOneGetOne do
  let(:cart) { create :cart }
  let(:cart_item) { cart.cart_items.find_by_product_id(product) }
  let(:product) { subject.products.first }
  subject { create :buy_one_get_one }

  before do
    cart.add_product product
  end

  describe '#kind' do
    it 'always as percentage' do
      expect(subject.kind).to eq 'percentage'
    end
  end

  describe '#percentage' do
    it 'gives 100% discount' do
      expect(subject.percentage).to eq 100.0
    end
  end

  describe '#apply' do
    let(:new_cart_item) { cart.cart_items.where(promotional: true).first }
    before { subject.apply(cart: cart, cart_item: cart_item) }

    it 'duplicates cart_item as promotional type and apply percentage discount' do
      expect(cart.cart_items.count).to eq 2
      expect(cart.cart_items.where(promotional: true).count).to eq 1
    end

    it 'apply discount to cart_item' do
      expect(new_cart_item.price).to eq Money.new(0)
    end

    context '#clear' do
      it 'should destroy promotional item' do
        expect { subject.clear }.to change { CartItem.count }.by(-1)
        expect(new_cart_item).to eq nil
      end
    end
  end
end
