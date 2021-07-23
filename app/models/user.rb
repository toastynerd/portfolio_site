class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :links, as: :linkable

  validate :valid_password_confirmation, on: :create
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  validates :username, presence: true, uniqueness: true

  private
  def valid_password_confirmation
    if self.password_confirmation == nil
      errors.add(:password_digest, "confirmation must be present to create")
    end
  end
end
