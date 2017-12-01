class AddDayColumnsToWalkingSchedules < ActiveRecord::Migration[5.0]
  def change
    add_column :walking_schedules, :monday_times, :string
    add_column :walking_schedules, :tuesday_times, :string
    add_column :walking_schedules, :wednesday_times, :string
    add_column :walking_schedules, :thursday_times, :string
    add_column :walking_schedules, :friday_times, :string
    add_column :walking_schedules, :saturday_times, :string
  end
end
