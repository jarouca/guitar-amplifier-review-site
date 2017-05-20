class Review < ApplicationRecord
  belongs_to :amplifier
  belongs_to :user
  has_many :votes

  validates :body, presence: true
  validates :amplifier_id, presence: true
  validates :user_id, presence: true
end
