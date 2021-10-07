class ProductsController < ApplicationController
  def index
    @products = Product.all
    respond_to { |format| format.json }
  end
end
