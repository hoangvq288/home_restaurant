class TablesController < ApplicationController
  before_action :set_table, except: %i[index create]

  def index
    @table = Table.new # For popup modal
    # Pass model object then convert to class to call method in service
    @tables = SearchService.search(@table, params).paginate(page: params[:page], per_page: params[:per_page])
  end

  def create
    @table = Table.new(table_params)
    if @table.save
      flash[:success] = 'Table created !'
    else
      flash[:error] = 'Error happened !'
    end
    redirect_to tables_path
  end

  def show; end

  def edit; end

  def update
    @table.assign_attributes(table_params)
    if @table.save
      flash[:success] = 'Table updated !'
    else
      flash[:error] = 'Error happened !'
    end
    redirect_to tables_path
  end

  def destroy
    if @table.destroy
      flash[:success] = 'Table destroyed !'
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
