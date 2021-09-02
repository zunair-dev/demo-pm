class AddColumnHoursWorkedToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :hours_worked, :int, default: 0
  end
end
