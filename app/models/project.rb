class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user

  validates :status, inclusion: { in: ['pending', 'in-progress', 'complete'] }

  STATUS_OPTIONS = [
    ['Pending', 'pending'],
    ['In progress', 'in-progress'],
    ['Complete', 'complete']
  ]

  def status
    if tasks.all? { |task| task.complete? }
      'complete'
    elsif tasks.any? { |task| task.in_progress? || task.complete? }
      'in-progress'
    else
      'pending'
    end
  end
end
