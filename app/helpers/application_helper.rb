module ApplicationHelper
  def format_date(date)
    date.strftime('%a, %b %d %Y, at %I:%M %p')
  end
end
