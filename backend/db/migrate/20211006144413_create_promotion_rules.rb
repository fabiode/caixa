class CreatePromotionRules < ActiveRecord::Migration[6.1]
  def change
    create_table :promotion_rules do |t|
      t.string :name
      t.monetize :amount
      t.decimal :percentage, precision: 5, scale: 2
      t.integer :kind
      t.string :type

      t.timestamps
    end
  end
end
