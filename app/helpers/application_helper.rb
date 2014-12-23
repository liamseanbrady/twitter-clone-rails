module ApplicationHelper
  def display_datetime(dt)
    dt.strftime("%b %d, %H:%M") # Dec 21, 18:05
  end

  def linkify_hashtags(str)
    str.gsub(/#(\S+[^\W])/, "<a href='/hashtags/\\1'>#\\1</a>").html_safe
  end

  def linkify_mentions(str)
    str.gsub(/@(\S+[^\W])/, "<a href='/\\1'>@\\1</a>").html_safe

    # str.gsub /@(\S+[^\W])/  do |match|
    #   match = match.slice(1...match.size)
    #   User.find_by(username: match) ? "<a href='/#{match}'>@#{match}</a>".html_safe : "@#{match}".html_safe
    # end
  end

  def linkify(str)
    str = linkify_hashtags(str)
    str = linkify_mentions(str)
  end
end
