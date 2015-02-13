class HomeController < ApplicationController
  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def index
    #TODO test these also
    @user = current_user
    @runs = Run.where(user: @user).count
    @day = Date.today.yday
    #TODO account for leap years, write a test for this math
    @needed_pace = ((365 - @user.total_distance) / (365-@day)).round(2)
    @run = Run.new

    @user_recent_activity = RecentActivity.new(@user)
    @all_recent_activity = RecentActivity.new()
    @leaderboard = Leaderboard.new(:total)

    @announcement = Announcement.for_user(current_user)
  end

  def leaderboard
    page = params.has_key?(:page) ? params[:page].to_i : 1
    @leaderboard = Leaderboard.new(params[:type], page)

    respond_to do |format|
      format.js
    end
  end

  def recent_activity
    page = params.has_key?(:page) ? params[:page].to_i : 1
    user = params.has_key?(:user_id) ? User.find(params[:user_id]) : nil
    @recent_activity = RecentActivity.new(user, page)

    respond_to do |format|
      format.js
    end
  end


end
