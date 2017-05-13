class Amplifier < ApplicationRecord
  validates :manufacturer, presence: true
  validates :model, presence: true
  

end
