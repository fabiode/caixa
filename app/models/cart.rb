class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items

  has_and_belongs_to_many :promotion_rules

  monetize :total_price_cents

  def add_product(product)
    raise ArgumentError, 'must be an Product' unless product.is_a? Product

    if paid_cart_items.find_by_product_id(product)
      increment_cart_item_quantity(product)
    else
      cart_items.create(product: product, quantity: 1)
    end
  end

  private

  def apply_promotions
    cart_items.each do |item|
      item.product.promotion_rules.each do |promo|
        promo.apply(cart: self, cart_item: item)
      end
    end
  end

  def recalculate_total_price
    self.total_price = Money.new(cart_items.sum(:price_cents))
  end

  def paid_cart_items
    cart_items.paid
  end

  def increment_cart_item_quantity(product)
    cart_item = cart_items.find_by_product_id(product)
    cart_item.increment!(:quantity, touch: true)
  end
end
