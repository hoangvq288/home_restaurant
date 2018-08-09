class DishesController < ApplicationController
  before_action :set_dish, only: [:show, :edit, :update, :destroy]

  def index
    @dish = Dish.new # For popup modal
    # column name for searching | Format should be { equal: [], range: [], like: [] }
    conditions = { equal: %w[id active], like: ['name'] }
    # Pass model object then convert to class to call method in service
    @dishes = SearchService.search(@dish, params, conditions).includes(:category).paginate(page: params[:page], per_page: params[:per_page])
  end

  def show; end

  def edit; end

  def create
    @dish = Dish.new(dish_params)

    if @dish.save
      flash[:notice] = 'Dish created !'
    else
      flash[:error] = @dish.errors.full_messages.join(" ! ")
    end
    redirect_to dishes_path
  end

  def update
    if @dish.update(dish_params)
      flash[:notice] = 'Dish updated !'
      redirect_to dishes_path
    else
      flash[:error] = @dish.errors.full_messages.join(" ! ")
      render 'edit'
    end
  end

  def destroy_multiple
    ids = params[:dish_ids].split(',')
    if Dish.where(id: ids).destroy_all
      flash[:notice] = 'Dishes destroyed !'
    else
      flash[:error] = 'Error happened !'
    end
    redirect_to dishes_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dish
    @dish = Dish.friendly.find(params[:id])
  end

  def dish_params
    params.require(:dish).permit(:category_id, :name, :price, :description, :active, :deleted_at)
  end
end
