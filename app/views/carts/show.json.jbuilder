json.id @cart.id
json.items @cart.cart_items
json.promotion_rules @cart.promotion_rules
json.total_price humanized_money_with_symbol(@cart.total_price)
