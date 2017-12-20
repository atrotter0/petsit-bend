class AddOverridesToTestimonials < ActiveRecord::Migration[5.0]
  def change
    add_column :testimonials, :first_name_override, :string
    add_column :testimonials, :last_name_override, :string
    add_column :testimonials, :date_override, :string
    add_column :testimonials, :external_url, :string
  end
end
