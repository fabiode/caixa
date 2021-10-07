FactoryBot.define do
  factory :promotion_rule do
    name  { 'New Rule' }
    type { 'PromotionRule' }

    trait :percentage do
      kind { 'percentage' }
      percentage { 66.6 }
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
end
