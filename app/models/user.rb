require "bcrypt"

class User < ActiveRecord::Base

  attr_accessor :password
  
  def authenticate(unencrypted_password)
    BCrypt::Password.new(password_digest) == unencrypted_password
  end
  
  before_save do
    self.password_digest = BCrypt::Password.create(password)
  end
  
  before_create do
    self.auto_login_token = SecureRandom.hex
  end
end
