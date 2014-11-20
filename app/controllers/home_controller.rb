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
    @leaderboard = Leaderboard.new(params[:type])
    @selected = params[:type]

    respond_to do |format|
      format.js
    end
  end


end
