class AddSecondaryColorToPets < ActiveRecord::Migration[5.0]
  def change
    add_column :pets, :secondary_color, :string
  end
end
