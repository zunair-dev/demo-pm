class AddHoursColumnToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :hours, :int
  end
end
