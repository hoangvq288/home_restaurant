module ApplicationHelper
  def date_time_format(date_time)
    date_time&.strftime('%d/%m/%Y at %I:%M%p')
  end

  def currency_format(money)
    "#{number_to_currency(money, precision: 0, unit: '', delimiter: '.')} VND"
  end
end
