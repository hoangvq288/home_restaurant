Rails.application.routes.draw do
  root 'application#home'
  resources :tables, except: [:new, :destroy] do
    collection do
      delete :destroy_multiple
    end
  end
end
