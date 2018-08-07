class AdminsController < ApplicationController
  def index
    @admin = Admin.new # For popup modal
    # column name for searching | Format should be { equal: [], range: [], like: [] }
    conditions = { equal: %w[id], like: %w[name email], date_range: %w[created_at last_sign_in_at] }
    # Pass model object then convert to class to call method in service
    @admins = SearchService.search(@admin, params, conditions).paginate(page: params[:page], per_page: params[:per_page])
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:notice] = 'Admin created !'
    else
      flash[:error] = 'Error happened !'
    end
    redirect_to admins_path
  end

  def admin_params
    params.require(:admin).permit(:email)
  end
end
