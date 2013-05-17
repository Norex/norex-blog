module TumblesHelper
  def format_date(date, format)
    unless date.nil?
      date.strftime(format)
    end
  end

  def random_colour
    ['blue', 'orange', 'pink', 'green'].sample
  end

  def tumble_link(tumble)
    link_to strip_tags(tumble.title), (tumble.url || tumble_path(tumble))
  end
end
