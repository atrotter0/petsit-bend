class AddUpdatedAtToReservations < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :created_at, :datetime
    add_column :reservations, :updated_at, :datetime
  end
end
