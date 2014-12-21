module ApplicationHelper
  def display_datetime(dt)
    dt.strftime("%b %d, %H:%M") # Dec 21, 18:05
  end
end
