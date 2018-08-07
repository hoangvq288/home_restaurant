module ApplicationHelper
  def date_time_format(date_time)
    date_time&.strftime('%d/%m/%Y at %I:%M%p')
  end
end
