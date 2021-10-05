FactoryBot.define do
  factory :product do
    name { 'Green Tea' }
    description { 'The very best of green tea leaves infused with love.' }
    price { 29.0 }
    sku { 'GR1' }
  end
end
