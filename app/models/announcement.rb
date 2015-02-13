class Announcement < ActiveRecord::Base

  def self.for_user(user)
    if Announcement.count == 0
      return nil
    end

    latest_announcement = Announcement.last

    if user.last_announcement_id && user.last_announcement_id >= latest_announcement.id
      return nil
    end

    if user.created_at > latest_announcement.created_at
      user.last_announcement_id = latest_announcement.id
      return nil
    end

    user.update_attribute(:last_announcement_id,latest_announcement.id)
    latest_announcement
  end
end
