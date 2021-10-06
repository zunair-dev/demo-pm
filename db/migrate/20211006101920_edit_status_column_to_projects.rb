class EditStatusColumnToProjects < ActiveRecord::Migration[6.1]
  def change
    remove_column :projects, :status
    add_column :projects, :status, :integer
  end
end
