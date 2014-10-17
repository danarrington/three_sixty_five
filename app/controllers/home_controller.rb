class HomeController < ApplicationController
  def index
    @user = current_user
    @runs = Run.where(user: @user).count
    @day = Date.today.yday
    #TODO account for leap years, write a test for this math
    @needed_pace = ((365 - @user.total_distance) / (365-@day)).round(1)
  end

end
