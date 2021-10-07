FactoryBot.define do
  factory :product do
    name { 'Green Tea' }
    description { 'The very best of green tea leaves infused with love.' }
    price { 3.11 }
    sku { 'GR1' }

    trait :strawberry do
      name { 'Strawberry' }
      description { 'Red as your heart, these little berries will make you smile.' }
      price { 5.00 }
      sku { 'SR1' }
    end

    trait :coffee do
      name { 'Coffee' }
      description { 'The dark roasted scent of awakeness!' }
      price { 11.23 }
      sku { 'SR1' }
    end
  end
end
