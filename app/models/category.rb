require 'nkf'

class Category < ActiveRecord::Base
  has_many :tasks, :dependent => :nullify
  
  before_validation :normalize_values
  
  validates :name, :presence => true, :length => {:maximum => 20}
  validates :name, :uniqueness => { :case_sensitive => false }

  ######################
  private
  ######################
  def normalize_values
     if name.present?
       self.name = NKF.nkf("-WwZ", name)
       self.name.strip!
     end
  end
end
