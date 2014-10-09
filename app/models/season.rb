class Season < ActiveRecord::Base
  def self.current_season
    order(:year).last
  end
end
