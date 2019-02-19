class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  # validation check columns
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true
  validates :role, presence: true

  # Relationships
  has_many :reservations
  has_many :books, through: :waitlists

  # Role checker targets
  IS_ADMIN = 1<<0
  IS_MEMBER = 1<<1

end
