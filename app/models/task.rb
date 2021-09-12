class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true

  validates :status, inclusion: { in: ['pending', 'in-progress', 'complete'] }

  STATUS_OPTIONS = [
    ['Pending', 'pending'],
    ['In progress', 'in-progress'],
    ['Complete', 'complete']
  ]

  def complete?
    status == 'complete'
  end

  def in_progress?
    status == 'in-progress'
  end

  def pending?
    status == 'pending'
  end
end
