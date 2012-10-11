class Room < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :token, :session_id
  before_create :generate_token!

  protected
  def generate_token!
  	self.token = SecureRandom.hex(3)
  end
end
