class AddUserIdToWalkingSchedules < ActiveRecord::Migration[5.0]
  def change
    add_column :walking_schedules, :user_id, :integer
  end
end
