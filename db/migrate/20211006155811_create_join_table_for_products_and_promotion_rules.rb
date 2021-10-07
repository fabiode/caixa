class CreateJoinTableForProductsAndPromotionRules < ActiveRecord::Migration[6.1]
  def change
    create_join_table :products, :promotion_rules do |t|
      t.index :product_id
      t.index :promotion_rule_id
    end
  end
end
