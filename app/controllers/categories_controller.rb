class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update]

  def index
    @category = Category.new # For popup modal
    # column name for searching | Format should be { equal: [], range: [], like: [] }
    conditions = { equal: %w[id active], like: ['name'] }
    # Pass model object then convert to class to call method in service
    @categories = SearchService.search(@category, params, conditions).paginate(page: params[:page], per_page: params[:per_page])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category created !'
    else
      flash[:error] = 'Error happened !'
    end
    redirect_to categories_path
  end

  def edit; end

  def update
    @category.assign_attributes(category_params)
    if @category.save
      flash[:notice] = 'Category updated !'
    else
      flash[:error] = 'Error happened !'
    end
    redirect_to categories_path
  end

  def destroy_multiple
    ids = params[:category_ids].split(',')
    if Category.where(id: ids).destroy_all
      flash[:notice] = 'Categories destroyed !'
    else
      flash[:error] = 'Error happened !'
    end
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :active)
  end
end
