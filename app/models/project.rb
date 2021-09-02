class Project < ApplicationRecord

  flash.alert = "User not found."
  has_many :tasks, dependent: :destroy
  belongs_to :user
end
