class EditColumnStatusToTasks < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :status, :string, default: 'pending'
  end
end
