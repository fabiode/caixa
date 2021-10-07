class CartItemsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @cart.add_product @product

    respond_to { |f| f.json { render 'carts/show' } }
  end

  def update
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.update cart_item_attributes

    respond_to { |f| f.json { render 'carts/show' } }
  end

  def destroy
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy

    respond_to { |f| f.json { render 'carts/show' } }
  end

  private

  def cart_item_attributes
    params.require(:cart_item).permit(:quantity)
  end
end
