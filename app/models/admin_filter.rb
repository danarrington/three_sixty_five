class AdminFilter
  include ActiveModel::Model
  attr_accessor :type, :from, :to 

  def filtered_user_data
    query = User.joins(:runs).group('users.id', :first_name, :last_name)
    if !type.blank?
      query = query.where('runs.runtype = ?', type)
    end
    if !from.blank?
      query = query.where('runs.created_at >= ?', from)
    end
    if !to.blank?
      query = query.where('runs.created_at <= ?', to)
    end
    query = query.order('distance desc')
      .select('SUM(distance) AS distance, COUNT(*) as count, users.id, first_name, last_name')
    
    query.map{|i| {
      first_name: i.first_name,
      last_name: i.last_name,
      distance: i.distance,
      count: i.count}} 
  end

end
