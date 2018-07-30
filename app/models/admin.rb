class Admin < ApplicationRecord
  devise :omniauthable, :trackable, omniauth_providers: [:google_oauth2]
end