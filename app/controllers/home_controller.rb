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

    @user_recent_activity = RecentUserActivity.new(@user)
    @leaderboard = Leaderboard.new(:total)
  end

  def leaderboard
    page = params.has_key?(:page) ? params[:page].to_i : 1
    @leaderboard = Leaderboard.new(params[:type], page)

    respond_to do |format|
      format.js
    end
  end

  def user_recent_activity
    page = params.has_key?(:page) ? params[:page].to_i : 1
    @user_recent_activity = RecentUserActivity.new(current_user, page)

    respond_to do |format|
      format.js
    end
  end


end
