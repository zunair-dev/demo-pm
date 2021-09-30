class AddColumDateToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :starting_date, :date
    add_column :tasks, :ending_date, :date
  end
end
