class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true

  enum status: [:pending, :complete, :in_progress]

  def self.update_status(params, task)
    unless params[:task][:status] == 1
      task.status = 2 unless params[:task][:hours] == 0
    end
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end

  def self.searchTask(search)
    # byebug
    if search
      where.not(status: 'complete').where('name LIKE ?', "%#{search}%")
    else
      where.not(status: 'complete')
    end
  end
end
