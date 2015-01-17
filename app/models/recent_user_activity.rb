class RecentUserActivity
  attr_reader :runs
  attr_reader :pages
  attr_reader :current_page
  attr_reader :user_id
  PER_PAGE=10


  def initialize(user = nil, page = 1)
    @user_id = user.id if user
    @current_page = page
    query = user ? user.runs : Run.all
    @runs = paged_query(@current_page, query).order(created_at: :desc)
    @pages = (query.length/PER_PAGE.to_f).ceil
  end

  private
  def paged_query(page, query)
    query.offset(PER_PAGE*(page-1)).limit(PER_PAGE)
  end
end
