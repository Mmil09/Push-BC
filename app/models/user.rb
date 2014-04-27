class User < ActiveRecord::Base
  extend FriendlyId
  include Sluggable

  friendly_id :username, use: [:slugged, :history]

  validates :username, :email, presence: true, uniqueness: true, case_sensitive: false
  validates :password , presence: true
  validates_confirmation_of :password, before: :save
  has_secure_password validations: false
  has_many :user_bootcamps
  has_many :bootcamps, through: :user_bootcamps
  has_many :reviews
  has_many :replies
  scope :case_insensitive_find, ->(username) { where("lower(username) = ?", username.downcase) }

  def is_bc_admin?(bootcamp_id)
    self.bootcamps.exists?(bootcamp_id) ? true : false
  end

  
  

end