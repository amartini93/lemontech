class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :registrations, dependent: :destroy
  has_many :attended_events, through: :registrations, source: :event
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id', dependent: :destroy
end
