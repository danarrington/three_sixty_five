class RecentUserActivity
  attr_reader :runs
  attr_reader :pages
  attr_reader :current_page
  PER_PAGE=10


  def initialize(user, page = 1)
    @current_page = page
    query = user.runs
    @runs = paged_query(@current_page, query).order(created_at: :desc)
    @pages = (query.length/PER_PAGE.to_f).ceil
  end

  private
  def paged_query(page, query)
    query.offset(PER_PAGE*(page-1)).limit(PER_PAGE)
  end
end