class Testimonial < ActiveRecord::Base
  belongs_to :user
  
  validates :body, presence: true, length: { maximum: 800 }

  def display_short_date
    self.created_at.strftime('%b %Y')
  end

  def first_name_display
    if first_name_override.present?
      return first_name_override
    else
      return self.user.first_name
    end
  end

  def last_name_display
    if last_name_override.present?
      return last_name_override
    else
      return self.user.last_name
    end
  end

  def date_display
    if date_override.present?
      return date_override
    else
      return self.display_short_date
    end
  end
end
