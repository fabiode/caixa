FactoryBot.define do
  factory :promotion_rule do
    name  { 'New Rule' }
    type { 'PromotionRule' }

    trait :percentage do
      kind { 'percentage' }
      percentage { 33.3 }
    end

    trait :amount do
      kind { 'amount' }
      amount { 0.50 }
    end
  end

  factory :buy_one_get_one, class: PromotionRules::BuyOneGetOne do
    name  { 'Green Tea Party!' }

    after(:create) do |promo|
      promo.products << create(:product)
    end
  end

  factory :bulk, class: PromotionRules::Bulk do
    name { 'Three is a Charm! Straberries drops 0.50' }
    trait :strawberry do
      kind { 'amount' }
      amount { 0.50 }

      after(:create) do |promo|
        promo.products << create(:product, :strawberry)
      end
    end

    trait :coffee do
      kind { 'percentage' }
      percentage { 33.3 }

      name { 'Three is a Charm! Straberries drops 0.50' }
      after(:create) do |promo|
        promo.products << create(:product, :coffee)
      end
    end
  end
end
