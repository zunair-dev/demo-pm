class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.belongs_to :task
      t.date :date

      t.timestamps
    end
  end
end
