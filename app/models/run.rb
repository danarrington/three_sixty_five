class Run < ActiveRecord::Base
  belongs_to :user
  belongs_to :season
  default_scope -> {where(season: Season.current_season)}

  validates_numericality_of :distance, :greater_than => 0
end
