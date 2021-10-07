module PromotionRules
  class Bulk < ::PromotionRule
    attr_accessor :cart,
                  :cart_item,
                  :product

    def apply(cart: nil, cart_item: nil)
      @cart = cart
      @cart_item = cart_item
      @product = cart_item.product

      clear and return false unless eligible?

      cart_item.price = calculated_price(product.price)
      cart_item.save!

      true
    end

    private

    def clear
      cart_item.price = product.price
      cart_item.save!
    end

    def eligible?
      cart_item.quantity >= 3
    end
  end
end
