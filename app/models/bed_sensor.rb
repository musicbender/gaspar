class BedSensor < ApplicationRecord
  validates :name, presence: true
  attribute :is_active, :boolean, default: false
  attribute :name, :string 
end 
 