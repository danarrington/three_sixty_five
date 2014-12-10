class Leaderboard
  attr_reader :users
  attr_reader :type
  attr_reader :pages
  attr_reader :current_page
  PER_PAGE=10

  def initialize(type, page = 1)
    @current_page = page
    @type = type
    if type.to_sym == :total
      query = User.order(total_distance: :desc)
      @users = paged_query(@current_page, query).map{|user| {name: "#{user.first_name}  #{user.last_name.first}", distance: user.total_distance, id: user.id}}
    else
      query = User.joins(:runs).where('runs.runtype = ?', Run.runtypes[type]).group('users.id', :first_name)
      @users = paged_query(@current_page, query).order('sum_distance desc').sum(:distance).map{|result| {name: result[0][1], distance: result[1]}}
    end
    @pages = (query.length/PER_PAGE.to_f).ceil
  end

  private
  def paged_query(page, query)
    query.offset(PER_PAGE*(page-1)).limit(PER_PAGE)
  end
end

