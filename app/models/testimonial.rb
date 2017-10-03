class Testimonial < ActiveRecord::Base
  belongs_to :user
  
  #validates :body, presence: true, length: { maximum: xx }
end