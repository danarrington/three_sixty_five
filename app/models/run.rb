class Run < ActiveRecord::Base
  belongs_to :user
  belongs_to :season
  default_scope -> {where(season: Season.current_season)}
  enum runtype: [:run, :walk, :bike, :swim, :misc]

  validates_numericality_of :distance, :greater_than => 0
  validates_presence_of :run_date

  def verb
    case self.runtype
      when 'bike'
        'ride'
      when 'misc'
        'activity'
      else
       self.runtype
    end
  end
end
