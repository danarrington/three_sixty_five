class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter do 
    redirect_to :new_user_session_path unless current_user && current_user.admin?
  end

  def stats
    @filter = AdminFilter.new(filter_params)
    @data = @filter.filtered_user_data
  end

  private
  def filter_params
    if params[:admin_filter]
      params.require(:admin_filter).permit(:type, :from, :to)
    end
  end
end
