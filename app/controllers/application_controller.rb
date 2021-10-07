class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  before_action :set_cart

  private

  def set_cart
    @cart ||= Cart.find_or_create_by(id: params[:cart_id])
  end
end
