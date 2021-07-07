class User < ApplicationRecord
  has_secure_password

  validate :valid_password_confirmation, on: :create
  validates :email, :username, presence: true

  private
  def valid_password_confirmation
    if self.password_confirmation == nil
      errors.add(:password_digest, "confirmation must be present to create")
    end
  end
end
