class TablesController < ApplicationController
  before_action :set_table, only: %i[show edit update]

  def index
    @table = Table.new # For popup modal
    # column name for searching | Format should be { equal: [], range: [], like: [] }
    conditions = { equal: %w[id seat_number active], like: ['name'] }
    # Pass model object then convert to class to call method in service
    @tables = SearchService.search(@table, params, conditions).paginate(page: params[:page], per_page: params[:per_page])
  end

  def create
    @table = Table.new(table_params)
    if @table.save
      flash[:notice] = 'Table created !'
    else
      flash[:error] = @table.errors.full_messages.join(" ! ")
    end
    redirect_to tables_path
  end

  def edit; end

  def update
    @table.assign_attributes(table_params)
    if @table.save
      flash[:notice] = 'Table updated !'
      redirect_to tables_path
    else
      flash[:error] = @table.errors.full_messages.join(" ! ")
      render 'edit'
    end
  end

  def destroy_multiple
    ids = params[:table_ids].split(',')
    if Table.where(id: ids).destroy_all
      flash[:notice] = 'Tables destroyed !'
    else
      flash[:error] = 'Error happened !'
    end
    redirect_to tables_path
  end

  def set_table
    @table = Table.friendly.find(params[:id])
  end

  def table_params
    params.require(:table).permit(:name, :seat_number, :active)
  end
end
