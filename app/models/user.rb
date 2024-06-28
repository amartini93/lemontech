class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :registrations
  has_many :events, through: :registrations
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id'
end
