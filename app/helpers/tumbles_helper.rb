module TumblesHelper
  def format_date(date, format)
    unless date.nil?
      date.strftime(format)
    end
  end

  def random_colour
    ['blue', 'orange', 'pink', 'green'].sample
  end
end
