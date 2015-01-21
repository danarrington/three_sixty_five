class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter do 
    redirect_to :new_user_session_path unless current_user && current_user.admin?
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

  private
  def filter_params
    if params[:admin_filter]
      params.require(:admin_filter).permit(:type, :from, :to)
    end
  end
end
