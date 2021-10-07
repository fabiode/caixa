json.array! @products do |p|
  json.id p.id
  json.name p.name
  json.description p.description
  json.price humanized_money_with_symbol(p.price)
  json.promotion_rules p.promotion_rules
end
