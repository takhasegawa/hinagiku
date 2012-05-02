require "bcrypt"

class User < ActiveRecord::Base
  has_many :tasks, :foreign_key => "owner_id", :dependent => :destroy
  has_many :categories, :foreign_key => "owner_id", :dependent => :destroy

  attr_accessor :password, :current_password, :new_password
  attr_writer :setting_password, :changing_password
  attr_accessible :login_name, :display_name, :password,
    :current_password, :new_password, :new_password_confirmation
  
  validates :login_name, :presence => true, :length => { :maximum => 20 },
    :uniqueness => { :case_sensitive => false }
  validates :display_name, :presence => true, :length => { :maximum => 20 }
  validates :current_password, :presence => { :if => :changing_password? }
  validates :new_password, :presence => { :if => :changing_password? },
    :length => { :minimum => 4, :allow_blank => true }, :confirmation => true
  validate do
    if changing_password? && !authenticate(current_password)
      errors.add(:current_password, :invalid)
    end
  end
  
  def setting_password?
    @setting_password
  end
  
  def changing_password?
    @changing_password
  end
  
  def authenticate(unencrypted_password)
    BCrypt::Password.new(password_digest) == unencrypted_password
  end
  
  before_save do
    if setting_password?
      self.password_digest = BCrypt::Password.create(password)
    elsif changing_password?
      self.password_digest = BCrypt::Password.create(new_password)
    end
  end
  
  before_create do
    self.auto_login_token = SecureRandom.hex
  end
end
