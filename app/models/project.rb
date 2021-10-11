class Project < ApplicationRecord
  validates :name, :cost, :hours, :starting_date, :ending_date, presence: true
  validates :name, uniqueness: true

  has_many :tasks, dependent: :destroy
  belongs_to :user
  has_many :assigns
  has_many :users, through: :assigns

  enum status: [:pending, :complete, :in_progress]

  def self.check_whole_status(project)
    result = true
    project.tasks.each do |t|
      unless t.status == 1
        result = false
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

  private

  def self.assign_projects(params, project)
    users = params[:project][:emp].select do |id|
      id = id.to_i
      Assign.create(project_id: project.id, user_id: User.find(id).id) unless id.zero?
    end
  end

  def self.delivery(project)
    result =  "n/a"
    project.tasks.each do |t|
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
