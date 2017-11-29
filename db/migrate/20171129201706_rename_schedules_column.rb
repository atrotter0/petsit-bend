class RenameSchedulesColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :walking_schedules, :schedule, :sunday_times
  end
end
