class User < ActiveRecord::Base
  extend FriendlyId
  include Sluggable
  require 'token_generator.rb'

  friendly_id :username, use: [:slugged, :history]

  validates :username, :email, presence: true, uniqueness: true, case_sensitive: false
  validates :password , presence: true, on: :create
  validates_confirmation_of :password, before: :save
  has_secure_password validations: false
  has_many :user_bootcamps
  has_many :bootcamps, through: :user_bootcamps
  has_many :reviews
  has_many :replies
  scope :case_insensitive_find, ->(username) { where("lower(username) = ?", username.downcase) }
  before_create :generate_confirmation_token, :update_confirm_sent_at

  
  def is_bc_admin?(bootcamp_id)
    self.bootcamps.exists?(bootcamp_id) ? true : false
  end

  def generate_confirmation_token
    self.confirmation_token = TokenGenerator.new.generate_token
  end
  
  def confirmed?
    self.confirmed_at != nil
  end

  def update_confirm_sent_at
    self.confirmation_sent_at = Time.now.utc
  end
  
  def confirm
    self.update!(confirmed_at: Time.now.utc)
  end
  

end