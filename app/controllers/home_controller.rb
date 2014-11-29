class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    #TODO test these also
    @user = current_user
    @runs = Run.where(user: @user).count
    @day = Date.today.yday
    #TODO account for leap years, write a test for this math
    @needed_pace = ((365 - @user.total_distance) / (365-@day)).round(1)
    @run = Run.new

    @leaderboard = Leaderboard.new(:total)
  end

  def leaderboard
    page = params.has_key?(:page) ? params[:page].to_i : 1
    @leaderboard = Leaderboard.new(params[:type], page)

    respond_to do |format|
      format.js
    end
  end


end
