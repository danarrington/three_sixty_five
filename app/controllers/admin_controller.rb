class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter do 
    redirect_to :user_root unless current_user && current_user.admin?
  end

  def stats
    @filter = AdminFilter.new(filter_params)
    @data = @filter.filtered_user_data
    @sums = {
      people: @data.count,
      runs: @data.map {|d| d[:count]}.reduce(0, :+),
      distance: @data.map {|d| d[:distance]}.reduce(0, :+),
    }
  end

  def restart
    @current_year = Season.current_season.year 
    @new_year = @current_year+1
    @run_count = Run.count
    @user_count = User.where('total_distance > 0').count
  end

  def execute_restart
    User.update_all(total_distance: 0)
    Season.create(year:Season.current_season.year+1)


    redirect_to stats_path
  end

  private
  def filter_params
    if params[:admin_filter]
      params.require(:admin_filter).permit(:type, :from, :to)
    end
  end
end
