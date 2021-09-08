class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user

  validates :status, inclusion: { in: ['pending', 'in-progress', 'complete'] }

  STATUS_OPTIONS = [
    ['Pending', 'pending'],
    ['In progress', 'in-progress'],
    ['Complete', 'complete']
  ]
end
