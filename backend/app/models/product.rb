class Product < ApplicationRecord
  has_one_attached :image

  has_and_belongs_to_many :promotion_rules

  monetize :price_cents, numericality: { greater_than: 0 }

  with_options presence: true do
    validates :name
    validates :price_cents
  end
end
