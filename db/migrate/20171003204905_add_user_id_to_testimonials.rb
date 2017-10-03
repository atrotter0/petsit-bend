class AddUserIdToTestimonials < ActiveRecord::Migration[5.0]
  def change
    add_column :testimonials, :user_id, :integer
  end
end
