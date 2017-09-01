class AddColorToPets < ActiveRecord::Migration[5.0]
  def change
    add_column :pets, :color, :string
    add_column :pets, :created_at, :datetime
    add_column :pets, :updated_at, :datetime
  end
end
