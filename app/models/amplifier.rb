class Amplifier < ApplicationRecord
  belongs_to :user
  has_many :reviews

  validates :manufacturer, presence: true
  validates :model, presence: true
  validates :user_id, presence: true
end
