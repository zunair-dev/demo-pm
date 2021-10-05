class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true

  # def status
  #   if (hours_worked == 0)
  #     'pending'
  #   elsif ((hours != hours_worked) && hours_worked != 0)
  #     'in-progress'
  #   else
  #     'pending'
  #   end
  # end

  def complete?
    status == 'complete'
  end

  def in_progress?
    status == 'in-progress'
  end

  def pending?
    status == 'pending'
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
