class Leaderboard
  attr_reader :users

  def initialize(type)
    if type == :total
      @users = User.order(total_distance: :desc).all.map{|user| {name: user.name, distance: user.total_distance}}
    else
      @users = User.joins(:runs).where('runs.runtype = ?', Run.runtypes[type]).group(:user_id, :name).order('sum_distance desc').sum(:distance).map{|result| {name: result[0][1], distance: result[1]}}
    end
  end
end

