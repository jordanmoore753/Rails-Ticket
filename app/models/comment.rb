class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :creator, class_name: 'User'

  validates :creator, presence: true
  validates :body, presence: true, length: { maximum: 200 }
end
