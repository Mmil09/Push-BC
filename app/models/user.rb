class User < ActiveRecord::Base
  extend FriendlyId
  include Sluggable

  friendly_id :username, use: [:slugged, :history]

  validates :username, :email, presence: true, uniqueness: true, case_sensitive: false
  validates :password , presence: true
  validates_confirmation_of :password
  validates_presence_of :password_confirmation
  has_secure_password validations: false
  has_many :user_bootcamps
  has_many :bootcamps, through: :user_bootcamps
  has_many :reviews

  def is_bc_admin?(id)
    self.bootcamps.exists?(id) ? true : false
  end
  

end