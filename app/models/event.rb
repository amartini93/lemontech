class Event < ApplicationRecord
  acts_as_paranoid # Enables soft deletion
  
  has_many :registrations
  has_many :users, through: :registrations
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  validates :name, :description, :date, :location, :capacity, presence: true
end
