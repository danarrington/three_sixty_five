module ApplicationHelper
TIME_PATTERN = {' hours'=>'h', ' minutes'=>'m', ' days'=>'d', ' hour'=>'h',
                ' minute'=>'m', ' day'=>'d', 'about'=>'', 'less than a'=>'1'}
  def short_time_ago(time)
    words = time_ago_in_words(time)
    words.gsub(Regexp.union(TIME_PATTERN.keys), TIME_PATTERN)
  end
end
