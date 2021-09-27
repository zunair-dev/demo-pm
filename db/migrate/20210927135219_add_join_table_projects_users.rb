class AddJoinTableProjectsUsers < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :projects do |t|
      t.belongs_to :users
      t.belongs_to :projects
    end
  end
end
