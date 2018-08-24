class CategoriesController < ApplicationController
  layout 'blank', only: :show
  before_action :set_category, only: %i[show edit update]

  def index
    @category = Category.new # For popup modal
    # column name for searching | Format should be { equal: [], range: [], like: [] }
    conditions = { equal: %w[id active], like: ['name'] }
    # Pass group_by & having condition to search service
    filter_group_by_condition(params)
    # Pass model object then convert to class to call method in service
    @categories = SearchService.search(@category, params, conditions, @join_table_array || [], @group_having_hash || {}).paginate(page: params[:page], per_page: params[:per_page])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category created !'
    else
      flash[:error] = @category.errors.full_messages.join(' ! ')
    end
    redirect_to categories_path
  end

  def edit; end

  def show; end

  def update
    @category.assign_attributes(category_params)
    if @category.save
      flash[:notice] = 'Category updated !'
      redirect_to categories_path
    else
      flash[:error] = @category.errors.full_messages.join(' ! ')
      render 'edit'
    end
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
    params.require(:category).permit(:name, :active, topping_ids: [])
  end

  # rubocop:disable all
  def filter_group_by_condition(params)
    return if params['s'].try(:[], 'dishes_count_from').blank? && params['s'].try(:[], 'dishes_count_to').blank? && 
              params['s'].try(:[], 'toppings_count_from').blank? && params['s'].try(:[], 'toppings_count_to').blank?
    @join_table_array = [:dishes, :toppings]
    having_clause = []
    having_clause << "COUNT(DISTINCT dishes) >= #{params['s']['dishes_count_from']}" if params['s'].try(:[], 'dishes_count_from').present?
    having_clause << "COUNT(DISTINCT dishes) <= #{params['s']['dishes_count_to']}" if params['s'].try(:[], 'dishes_count_to').present?
    having_clause << "COUNT(DISTINCT toppings) >= #{params['s']['toppings_count_from']}" if params['s'].try(:[], 'toppings_count_from').present?
    having_clause << "COUNT(DISTINCT toppings) <= #{params['s']['toppings_count_to']}" if params['s'].try(:[], 'toppings_count_to').present?
    @group_having_hash = { 'categories.id' => having_clause.join(' AND ') }
  end
end
