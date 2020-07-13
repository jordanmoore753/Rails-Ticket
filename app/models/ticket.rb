class Ticket < ApplicationRecord
  belongs_to :project
  has_many :tags
end
