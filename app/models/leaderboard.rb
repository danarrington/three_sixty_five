class Leaderboard
  attr_reader :total_distance

  def initialize
    @total_distance = User.order(total_distance: :desc).all.map{|user| {name: user.name, total_distance: user.total_distance}}
  end
end

