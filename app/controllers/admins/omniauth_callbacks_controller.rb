module Admins
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      info = request.env['omniauth.auth']['info']
      admin = Admin.find_by(email: info['email'])
      if admin
        admin.update(name: info['name'], image: info['image'])
        flash[:notice] = 'Sign in successfully !'
        sign_in_and_redirect admin
      else
        flash[:danger] = 'Account not found !'
        redirect_to new_admin_session_path
      end
    end
  end
end