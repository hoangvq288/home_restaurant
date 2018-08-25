class ToppingsController < ApplicationController
  before_action :set_topping, only: [:show, :edit, :update, :destroy]

  def index
    @topping = Topping.new # For popup modal
    # column name for searching | Format should be { equal: [], range: [], like: [] }
    conditions = { equal: %w[id active], like: ['name'], range: ['price'] }
    # Pass model object then convert to class to call method in service
    @toppings = SearchService.search(@topping, params, conditions).paginate(page: params[:page], per_page: params[:per_page])
  end

  def show; end

  def edit; end

  def create
    @topping = Topping.new(topping_params)
    if @topping.save
      flash[:notice] = 'Topping created !'
    else
      flash[:error] = @topping.errors.full_messages.join(' ! ')
    end
    redirect_to toppings_path
  end

  def update
    @topping.assign_attributes(topping_params)
    if @topping.save
      flash[:notice] = 'Topping updated !'
      redirect_to toppings_path
    else
      flash[:error] = @topping.errors.full_messages.join(' ! ')
      render 'edit'
    end
  end

  def destroy_multiple
    ids = params[:topping_ids].split(',')
    if Topping.where(id: ids).destroy_all
      flash[:notice] = 'Tables destroyed !'
    else
      flash[:error] = 'Error happened !'
    end
    redirect_to toppings_path
  end

  private

  def set_topping
    @topping = Topping.friendly.find(params[:id])
  end

  def topping_params
    params.require(:topping).permit(:name, :active, :price, :deleted_at, :slug)
  end
end
