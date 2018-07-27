# rubocop:disable all
class SearchService
  class << self
    def search(object, params, join_table_array = nil)
      model = object.class
      return model.all if params[:s].blank? # For no searching

      # Using table attribute to compare params attribute
      search_params = params[:s].to_unsafe_hash.select { |_,v| v.present? }
      attribute_name = model.attribute_names.reject { |v| search_params.keys.exclude?(v) }

      query = []
      attribute_name.each do |attr|
        param_attr = params[:s][attr]
         # Use equal if type is integer or boolean & otherwise use string
        if [:integer, :boolean].include? (model.type_for_attribute(attr).type)
          query << "#{attr} = #{param_attr}"
        elsif model.type_for_attribute(attr).type == :string
          query << "lower(#{attr}) LIKE lower('%#{param_attr}%')"
        end
      end

      model.where(query.join(" AND "))
      # TO DO : implement joins table
    end
  end
end
