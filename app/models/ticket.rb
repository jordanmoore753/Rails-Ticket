class Ticket < ApplicationRecord
  belongs_to :project

  validates :name, presence: true, length: { maximum: 25 }
  validates :body, presence: true, length: { maximum: 200 }
  validates :status, presence: true, inclusion: { in: %w(blocked fixed in_progress new)}
  validates :assignee, presence: true
  validates :project_id, presence: true
end
