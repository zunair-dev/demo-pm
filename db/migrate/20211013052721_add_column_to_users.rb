class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :logs, :user, index: true
  end
end
