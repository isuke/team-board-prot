module ApplicationHelper
  def full_title(page_title="")
    base_title = "Team Board Prototype"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def format_time(time, short: false)
    if short
      time.strftime('(%Z) %m-%d %H:%M')
    else
      time.strftime('(%Z) %Y-%m-%d %H:%M:%S.%L')
    end
  end

  def diff(text1, text2)
    Diffy::Diff.new(text1, text2, include_plus_and_minus_in_html: true).to_s
  end
end
