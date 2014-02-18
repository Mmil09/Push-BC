class User < ActiveRecord::Base
  validates :username, :email, presence: true, uniqueness: true, case_sensitive: false
  validates :password , presence: true
  has_secure_password validations: false

end