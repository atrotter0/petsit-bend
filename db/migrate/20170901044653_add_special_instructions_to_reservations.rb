class AddSpecialInstructionsToReservations < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :medications, :boolean, default: false
    add_column :reservations, :special_instructions, :text
  end
end
