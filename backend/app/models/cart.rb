class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items

  has_and_belongs_to_many :promotion_rules

  monetize :total_price_cents

  after_touch :recalculate_total_price

  def add_product(product)
    raise ArgumentError, 'must be an Product' unless product.is_a? Product

    cart_item = if paid_cart_items.find_by_product_id(product)
                  increment_cart_item_quantity(product)
                else
                  cart_items.create(product: product, quantity: 1)
                end

    apply_promotions(product, cart_item)
    touch
  end

  def apply_promotions(product, cart_item)
    product.promotion_rules.each do |promo|
      promo.apply(cart: self, cart_item: cart_item)
    end
  end

  def recalculate_total_price
    self.total_price = cart_items.sum(&:total_price)
    save!
  end

  private

  def paid_cart_items
    cart_items.paid
  end

  def increment_cart_item_quantity(product)
    cart_item = cart_items.find_by_product_id(product)
    cart_item.increment!(:quantity, touch: true)
    cart_item
  end
end
