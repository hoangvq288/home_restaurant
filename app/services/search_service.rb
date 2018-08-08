# rubocop:disable all
class SearchService
  class << self
    def search(object, params, conditions = {}, join_table_array = nil)
      model = object.class
      return model.all if params['s'].blank? # For no searching

      # Using table attribute to compare params attribute
      search_params = params['s'].select { |_,v| v.present? } # Remove empty search value
      handle_conditions(conditions, search_params)
      model.where(@query.join(" AND "))
      # TO DO : implement joins table
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

# Company.joins(:users).group('companies.id').having('sum(users.tier_level) > 16')
# Company.joins(:users).group('companies.id').having('count(users) >= 16')
