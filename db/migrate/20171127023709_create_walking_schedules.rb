class CreateWalkingSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :walking_schedules do |t|
      t.string :pet_list
      t.string :schedule
      t.timestamps
    end
  end
end
