class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true

  validates :status, inclusion: { in: ['pending', 'in-progress', 'complete'] }

  STATUS_OPTIONS = [
    ['Pending', 'pending'],
    ['In progress', 'in-progress'],
    ['Complete', 'complete']
  ]
end
