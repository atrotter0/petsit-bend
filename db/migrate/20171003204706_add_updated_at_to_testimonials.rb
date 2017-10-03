class AddUpdatedAtToTestimonials < ActiveRecord::Migration[5.0]
  def change
    add_column :testimonials, :created_at, :datetime
    add_column :testimonials, :updated_at, :datetime
  end
end
