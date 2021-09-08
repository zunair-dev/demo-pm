class AddCostToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :cost, :float
  end
end
