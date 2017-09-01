class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.integer :number_of_pets
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
