class Task < ApplicationRecord
  validates :name, :hours, :starting_date, :ending_date, presence: true
  validates :name, uniqueness: true

  belongs_to :project
  belongs_to :user, optional: true
  has_many :logs, dependent: :destroy

  enum status: [:pending, :complete, :in_progress]

  def self.update_status(params, task)
    if params[:task][:hours_worked] == 0
      params[:task][:status] = "pending"
    elsif params[:task][:hours_worked] > 0
      unless params[:task][:status] == "complete"
        params[:task][:status] = "in_progress"
      end
    end
  end

  def self.update_project_status(task)
    if task.status == "complete"
      if Project.check_whole_status(task.project)
        task.project.status = 1
      else
        task.project.status = 2
      end
    elsif task.status == "in_progress"
      task.project.status = 2
    elsif task.status == "pending"
      if task.project.status == "pending"
        task.project.status = 0
      elsif task.project.status == 2 or task.project.status == 1
        task.project.status = 2
      end
    end
    task.project.save
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end

  def self.add_logs(params, task)
    Log.create(task_id: task.id, date: params[:task][:date], hours: params[:task][:hours_worked], user_id: task.user_id)
    sum = 0
    if task.logs.any?
      task.logs.each do |log|
        sum = sum + log.hours
      end
    end
    params[:task][:hours_worked] = sum
  end

  def self.searchTask(search)
    if search
      where.not(status: 'complete').where('name LIKE ?', "%#{search}%")
    else
      where.not(status: 'complete')
    end
  end
end
