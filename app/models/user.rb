class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :projects, dependent: :destroy
  has_many :tasks

  ROLE_OPTIONS = [
    ['Employee', 0],
    ['Admin', 1]
  ]

  DESIGNATIONS = [
    'Chief Executive Officer', 'Project Manager', 'Human Resources',
    'Software Engineer', 'Associate Software Engineer','Employee', 
  ]
end
