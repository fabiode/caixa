class CartItem < ApplicationRecord
  belongs_to :product

  monetize :price_cents

  with_options presence: true do
    validates :price_cents
    validates :product
    validates :quantity, numericality: { greater_than: 0 }
  end

  scope :paid, -> { where(promotional: false) }
  scope :promotional, -> { where(promotional: true) }

  after_initialize :set_price, unless: :promotional?
  after_initialize :set_quantity

  def set_price
    self.price = product.price if price == 0
  end

  def set_quantity
    self.quantity ||= 1
  end

  def total_price
    price * quantity
  end

  def destroyable?
    !promotional?
  end

  def destroy(promo_bypass = false)
    unless promo_bypass || destroyable?
      raise PromotionalItemError,
            <<-ES
              Promotional items cannot be destroyed by destroy.
              If you are sure what you're doing, use destroy_promotional! instead.
            ES
              .squish

    end

    # XXX:  () must be used for zeroing arguments
    super()
  end

  def destroy_promotional!
    destroy(true)
  end
end

class PromotionalItemError < StandardError; end
