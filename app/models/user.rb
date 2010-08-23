require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password #virtual attribute
  
  # Tell rails which attributes of model can be modified by users submitting requests with browser
  # Important for preventing a mass assignment vulnerability
  attr_accessible :name, :email, :password, :password_confirmation
  
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates_presence_of   :name, :email
  validates_length_of     :name, :maximum => 50
  validates_format_of     :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false
  
  # Automatically create the virtual attribute 'password_confirmation'. 
  validates_confirmation_of :password

  # Password validations.
  validates_presence_of :password
  validates_length_of	:password, :within => 6..40

  before_save :encrypt_password
  
  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email) 
    return nil if user.nil? 
    return user if user.has_password?(submitted_password)
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt
      self.encrypted_password = encrypt(self.password)
    end
    
    def encrypt(string)
      secure_hash("#{self.salt}#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}#{self.password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
  
end











