class CreateJoinTableForCartsAndPromotionRules < ActiveRecord::Migration[6.1]
  def change
    create_join_table :carts, :promotion_rules do |t|
      t.index :cart_id
      t.index :promotion_rule_id
    end
  end
end
