class CartItem < ApplicationRecord
  belongs_to :product

  monetize :price_cents, numericality: { greater_than: 0 }

  with_options presence: true do
    validates :price_cents
    validates :product
    validates :quantity, numericality: { greater_than: 0 }
  end

  after_initialize :set_price, unless: :promotional?

  def set_price
    self.price = product.price
  end

  def destroyable?
    !promotional?
  end

  def destroy
    raise PromotionalItemError, 'Promotional items cannot be destroyed by itself' unless destroyable?

    super
  end
end

class PromotionalItemError < StandardError; end
