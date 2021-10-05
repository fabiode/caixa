class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items

  monetize :total_price_cents

  def add_product(product)
    raise ArgumentError, 'must be an Product' unless product.is_a? Product

    increment_cart_item_quantity(product) and return if products.include?(product)

    cart_items.create(product: product, quantity: 1)

    recalculate_total_price
  end

  private

  def recalculate_total_price
    self.total_price = Money.new(cart_items.sum(:price_cents))
  end

  def increment_cart_item_quantity(product)
    cart_item = cart_items.find_by_product_id(product)
    cart_item.increment!(:quantity, touch: true)
  end
end
