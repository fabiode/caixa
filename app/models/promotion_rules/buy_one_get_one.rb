module PromotionRules
  class BuyOneGetOne < ::PromotionRule
    attr_accessor :cart,
                  :cart_item,
                  :product

    def apply(cart: nil, cart_item: nil)
      @cart = cart
      @cart_item = cart_item
      @product = cart_item.product

      clear and return false unless eligible?

      new_item = cart_item.deep_dup
      new_item.product = product

      new_item.promotional = true
      new_item.price = calculated_price(product.price)

      new_item.save!
      cart.cart_items << new_item

      true
    end

    def kind
      'percentage'
    end

    def percentage
      100.0
    end

    private

    def clear
      cart.cart_items.where(product: product, promotional: true).each(&:destroy_promotional!)
    end

    def eligible?(eligible_product = product)
      cart.products.include?(eligible_product)
    end
  end
end
