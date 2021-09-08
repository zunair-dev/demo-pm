class AddStatusColumnToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :status, :string
  end
end
