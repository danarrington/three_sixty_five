class User < ActiveRecord::Base
  has_many :runs
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def print_name
    "#{first_name.capitalize} #{last_name.capitalize.first}"
  end

  def recalculate_total_distance!
    self.update(total_distance: self.runs.sum(:distance))
  end
end
