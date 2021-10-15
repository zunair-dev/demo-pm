class AddColumnToLogs < ActiveRecord::Migration[6.1]
  def change
    add_column :logs, :hours, :int
  end
end
