class Project < ApplicationRecord
  validates :name, :cost, :hours, :starting_date, :ending_date, presence: true
  validates :name, uniqueness: true

  has_many :tasks, dependent: :destroy
  belongs_to :user
  has_many :assigns
  has_many :users, through: :assigns

  enum status: [:pending, :complete, :in_progress]

  def self.check_whole_status(project)
    result = false
    project.tasks.each do |t|
      unless t.status == "complete "
        result = true
      else
        result == false
      end
    end
      result
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end

  def self.logged_hours(project)
    sum = 0
    project.tasks.each do |t|
      sum += t.hours_worked
    end
    sum
  end

  private

  def self.assign_projects(params, project)
    users = params[:project][:emp].select do |user|
      user = user.to_i
      Assign.create(project_id: project.id, user_id: User.find(user).id) unless user.zero?
    end
  end

  def self.delivery(tasks)
    result =  "n/a"
    tasks.each do |t|
      if t.status != "complete" && t.ending_date > Date.today
        result = "Due Delivery"
      elsif t.status == "complete" && t.ending_date >= Date.today
        result = "On Time Delivery"
      elsif t.status == "complete" && t.ending_date > Date.today
        result = "Late Delivered"
      else
        result = "Delivery is in Process"
      end
    end
    result
  end
end
