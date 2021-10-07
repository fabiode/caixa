class PromotionRule < ApplicationRecord
  enum kind: { percentage: 1, amount: 2 }, _suffix: true

  monetize :amount_cents, allow_nil: true

  has_and_belongs_to_many :carts
  has_and_belongs_to_many :products

  with_options presence: true do
    validates :name
    validates :type
    validates :amount, if: :amount_kind?
  end

  validates :percentage, numericality: { greater_than: 0.0 }, presence: true, if: :percentage_kind?

  private

  def calculated_price(product_amount)
    if percentage_kind?
      product_amount - (product_amount * percentage) / 100
    elsif amount_kind?
      product_amount - amount
    end
  end
end

# declaring module for nesting single table inheritance promotion rules
module PromotionRules; end
