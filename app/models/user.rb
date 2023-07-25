class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :groups, dependent: :destroy

  # has_secure_password

  enum role: { admin: 1, customer: 2 }

  attr_accessor :login
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.find_for_database_authentication warden_condition
    # binding.pry
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where(
      ["lower(username)= :value OR lower(email) = :value",{
        value: login.strip.downcase
      }]
    ).first
  end
end
