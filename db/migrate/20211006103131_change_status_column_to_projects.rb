class ChangeStatusColumnToProjects < ActiveRecord::Migration[6.1]
  def change
    change_column :projects, :status, :integer, default: 0
  end
end
