json.id @cart.id
json.items @cart.cart_items do |i|
  json.id i.id
  json.quantity i.quantity
  json.price humanized_money_with_symbol(i.price)
  json.promotional i.promotional
  json.product do
    json.id i.product.id
    json.name i.product.name
    json.description i.product.description
  end
end
json.promotion_rules @cart.promotion_rules
json.total_price humanized_money_with_symbol(@cart.total_price)
