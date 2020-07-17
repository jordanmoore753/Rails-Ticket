class Ticket < ApplicationRecord
  STATUSES = %w(new blocked fixed in_progress)
  
  validates :name, presence: true, length: { maximum: 25 }
  validates :body, presence: true, length: { maximum: 200 }
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :project_id, presence: true

  belongs_to :project
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :creator, class_name: 'User'

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
end
