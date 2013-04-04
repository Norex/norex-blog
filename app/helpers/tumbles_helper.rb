module TumblesHelper
  def format_date(date, format)
    unless date.nil?
      date.strftime(format)
    end
  end
end
