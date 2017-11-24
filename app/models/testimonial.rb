class Testimonial < ActiveRecord::Base
  belongs_to :user
  
  validates :body, presence: true, length: { maximum: 800 }

  def display_short_date
    self.created_at.strftime('%b %Y')
  end
end
