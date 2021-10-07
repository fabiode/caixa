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

      create_new_item unless existing_promo

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

    def existing_promo
      cart.cart_items.find_by(product: product, promotional: true)
    end

    def create_new_item
      new_item = CartItem.new(product: product)

      new_item.cart = cart
      new_item.quantity = 1
      new_item.promotional = true
      new_item.price = calculated_price(product.price)

      new_item.save!
    end

    def eligible?
      cart.cart_items.find_by(product: product, promotional: false)
    end
  end
end
