Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  defaults format: :json do
    resources :carts, only: :show do
      resources :cart_items, as: :items, except: %i[edit index]
    end

    resources :products, only: :index
  end
end
