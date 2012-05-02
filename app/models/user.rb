require "bcrypt"

class User < ActiveRecord::Base
  has_many :tasks, :foreign_key => "owner_id", :dependent => :destroy
  has_many :categories, :foreign_key => "owner_id", :dependent => :destroy

  attr_accessor :password
  attr_accessible :login_name, :display_name, :password
  
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
