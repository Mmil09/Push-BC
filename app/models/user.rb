class User < ActiveRecord::Base
  extend FriendlyId
  include Sluggable

  friendly_id :username, use: [:slugged, :history]

  validates :username, :email, presence: true, uniqueness: true, case_sensitive: false
  validates :password , presence: true
  has_secure_password validations: false
  has_many :user_bootcamps
  has_many :bootcamps, through: :user_bootcamps
  

end