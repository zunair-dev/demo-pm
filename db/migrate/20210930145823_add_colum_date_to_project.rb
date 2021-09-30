class AddColumDateToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :starting_date, :date
    add_column :projects, :ending_date, :date
  end
end
