# rubocop:disable all
class SearchService
  class << self
    def search(object, params, conditions = {}, join_table_array = [], group_having_hash = {})
      model = object.class
      return model.all if params['s'].blank? # For no searching

      # Check any table is joined
      model = model.joins(join_table_array) if join_table_array.present?
      # Using table attribute to compare params attribute
      search_params = params['s'].select { |_,v| v.present? } # Remove empty search value
      handle_conditions(conditions, search_params)
      if group_having_hash.present?
        model.where(@query.join(" AND ")).group(group_having_hash.keys[0]).having(group_having_hash.values[0])
      else
        model.where(@query.join(" AND "))
      end
    end

    def handle_conditions(conditions = {}, search_params)
      @query = []
      # Loop to detect searching requirements then compare with conditions in controller
      search_params.each do |param_key, param_value|
        table_name = param_key.split('.')[0]

        conditions[:equal]&.each do |column_name|
          @query << "#{table_name}.#{column_name} = #{param_value}" if param_key == "#{table_name}.#{column_name}"
        end

        conditions[:like]&.each do |column_name|
          @query << "lower(#{table_name}.#{column_name}) LIKE lower('%#{param_value}%')" if param_key == "#{table_name}.#{column_name}"
        end

        conditions[:range]&.each do |column_name|
          if param_key == "#{table_name}.#{column_name}_from"
            @query << "#{table_name}.#{column_name} >= #{param_value}"
          elsif param_key == "#{table_name}.#{column_name}_to"
            @query << "#{table_name}.#{column_name} <= #{param_value}"
          end
        end

        conditions[:date_range]&.each do |column_name|
          start_date = param_value.split(" - ")[0]
          end_date = param_value.split(" - ")[1]
          @query << "#{table_name}.#{column_name} >= '#{start_date}' AND #{table_name}.#{column_name} <= '#{end_date}'" if param_key == "#{table_name}.#{column_name}"
        end
      end
    end
  end
end
