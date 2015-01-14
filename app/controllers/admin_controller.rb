class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter do 
    redirect_to :new_user_session_path unless current_user && current_user.admin?
  end

  def stats
    @filter = AdminFilter.new(filter_params)
    query = User.joins(:runs).group('users.id', :first_name, :last_name)
    if !@filter.type.blank?
      query = query.where('runs.runtype = ?', @filter.type)
    end
    if !@filter.from.blank?
      query = query.where('runs.created_at > ?', @filter.from)
    end
    if !@filter.to.blank?
      query = query.where('runs.created_at < ?', @filter.to)
    end
    query = query.order('distance desc')
      .select('SUM(distance) AS distance, COUNT(*) as count, users.id, first_name, last_name')

    @data = query.map{|i| {
      first_name: i.first_name,
      last_name: i.last_name,
      distance: i.distance,
      count: i.count}} 
  end

  private
  def filter_params
    if params[:admin_filter]
      params.require(:admin_filter).permit(:type, :from, :to)
    end
  end
end
