class Tag < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  has_many :taggings, dependent: :destroy

  scope :counts, -> {
    left_outer_joins(:taggings).select('tags.*').group('id')
  }

  scope :alphabetize, -> {
    order(:name)
  }
end
