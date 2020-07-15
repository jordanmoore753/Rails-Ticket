class Project < ApplicationRecord
  has_many :tickets

  validates :name, presence: true, length: { maximum: 25 }
  validates :description, presence: true, length: { maximum: 200 }
end
