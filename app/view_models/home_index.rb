class HomeIndex

  attr_reader :user, :run_count, :day, :needed_pace, :run, :user_recent_activity,
    :all_recent_activity, :leaderboard, :announcement
  
  def initialize(user)
    @user = user
    @run_count = user.runs.count
    @day = Date.today.yday
    @needed_pace = ((365 - @user.total_distance) / (365-@day)).round(2)

    @run = Run.new

    @user_recent_activity = RecentActivity.new(@user)
    @all_recent_activity = RecentActivity.new()
    @leaderboard = Leaderboard.new(:total)

    @announcement = Announcement.for_user(@user)
  end
end
