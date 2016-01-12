class AdminFilter
  include ActiveModel::Model
  attr_accessor :type, :from, :to 

  def filtered_user_data
    # custom joins to get around default scope.  There is a Rails 4 bug
    query = User.joins('INNER JOIN runs ON runs.user_id = users.id').group('users.id', :first_name, :last_name)
    if !type.blank?
      query = query.where('runs.runtype = ?', type)
    end
    if !from.blank?
      query = query.where('runs.run_date >= ?', from)
    end
    if !to.blank?
      query = query.where('runs.run_date <= ?', to)
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
