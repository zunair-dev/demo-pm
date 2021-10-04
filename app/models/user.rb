class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :self_projects, class_name: "Project", dependent: :destroy
  has_many :tasks
  has_many :assigns
  has_many :projects, through: :assigns

  validates :email, presence: { messages: "Mail shouldn't be empty" }
  validates :email, uniqueness: true
  ROLE_OPTIONS = [
    ['Employee', 0],
    ['Admin', 1]
  ]

  DESIGNATIONS = [
    'Chief Executive Officer', 'Project Manager', 'Human Resources',
    'Software Engineer', 'Associate Software Engineer','Employee', 
  ]
end
