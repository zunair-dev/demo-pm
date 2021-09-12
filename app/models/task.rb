class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true

  def status
    if (hours == hours_worked)
      'complete'
    elsif ((hours != hours_worked) && hours_worked != 0)
      'in-progress'
    else
      'pending'
    end
  end

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
