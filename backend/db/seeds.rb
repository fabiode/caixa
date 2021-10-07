include FactoryBot::Syntax::Methods

buy_one_get_one_promo = create :buy_one_get_one

fixed_price_bulk_promo = create :bulk, :strawberry

percentage_bulk_promo = create :bulk, :coffee
