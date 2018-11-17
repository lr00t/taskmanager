class User < ApplicationRecord
  has_secure_password

  enum role: { user: 0, admin: 1}

  has_many :tasks, -> { ordered }, dependent: :destroy, inverse_of: :user

  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :password, length: {within: 6..40}

end
