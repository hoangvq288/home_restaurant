Rails.application.routes.draw do
  root 'application#home'

  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }

  devise_scope :admin do
    get 'sign_in', to: 'devise/sessions#new', as: :new_admin_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_admin_session
  end


  # ====== TABLE ROUTES ======
  resources :tables, except: %i[new destroy] do
    collection do
      delete :destroy_multiple
    end
  end

  # ====== ADMIN ROUTES ======
  resources :admins, except: %i[new destroy]

  # ====== CATEGORY ROUTES ======
  resources :categories, except: %i[new destroy] do
    collection do
      delete :destroy_multiple
    end
  end

  # ====== DISH ROUTES ======
  resources :dishes, except: %i[new destroy] do
    collection do
      delete :destroy_multiple
    end
  end

  # ====== DISH ROUTES ======
  resources :toppings, except: %i[new destroy] do
    collection do
      delete :destroy_multiple
    end
  end
end
