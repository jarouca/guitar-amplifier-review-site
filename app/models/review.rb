class Review < ApplicationRecord
  belongs_to :amplifier

  validates :body, presence: true
  validates :amplifier_id, presence: true
  validates :user_id, presence: true
end
