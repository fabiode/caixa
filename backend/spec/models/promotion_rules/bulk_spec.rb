require 'rails_helper'

RSpec.describe PromotionRules::Bulk do
  let(:cart) { create :cart }
  let(:cart_item) { cart.cart_items.find_by_product_id(product) }
  let(:product) { subject.products.first }

  before do
    cart.add_product product
  end

  context 'not eligible' do
    context 'amount discount' do
      subject { create :bulk, :strawberry }

      describe '#apply' do
        before { subject.apply(cart: cart, cart_item: cart_item) }

        it 'should not give discount' do
          expect(cart_item.price).to eq Money.new(500)
        end
      end
    end
  end

  context 'eligible' do
    before { allow(cart_item).to receive(:quantity).and_return(3) }

    context 'amount discount' do
      subject { create :bulk, :strawberry }

      describe '#apply' do
        before { subject.apply(cart: cart, cart_item: cart_item) }

        it 'should give discount of 0.50' do
          expect(cart_item.price).to eq Money.new(450)
        end

        describe '#clear' do
          before { allow(cart_item).to receive(:quantity).and_return(2) }

          it 'should destroy promotional item' do
            expect(cart_item.price).to eq Money.new(450)
            subject.apply(cart: cart, cart_item: cart_item)
            expect(cart_item.price).to eq Money.new(500)
          end
        end
      end
    end

    context 'percentage discount' do
      subject { create :bulk, :coffee }

      describe '#apply' do
        before { subject.apply(cart: cart, cart_item: cart_item) }

        it 'should give discount of 3.75' do
          expect(cart_item.price).to eq Money.new(749)
        end

        describe '#clear' do
          before { allow(cart_item).to receive(:quantity).and_return(2) }

          it 'should destroy promotional item' do
            expect(cart_item.price).to eq Money.new(749)
            subject.apply(cart: cart, cart_item: cart_item)
            expect(cart_item.price).to eq Money.new(1123)
          end
        end
      end
    end
  end
end
