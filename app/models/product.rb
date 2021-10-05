class Product < ApplicationRecord
  has_one_attached :image

  monetize :price_cents, numericality: { greater_than: 0 }

  with_options presence: true do
    validates :name
    validates :price_cents
  end
end
