class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.monetize :total_price

      t.timestamps
    end
  end
end
