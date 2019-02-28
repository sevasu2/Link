class Comment < ApplicationRecord
  belongs_to :entry

  validates :comment, presence: true, length: { maximum: 1000 }
end
