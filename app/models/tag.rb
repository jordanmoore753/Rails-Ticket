class Tag < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  has_many :taggings, dependent: :destroy
end
