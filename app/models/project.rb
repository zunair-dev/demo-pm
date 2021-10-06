class Project < ApplicationRecord
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
end
