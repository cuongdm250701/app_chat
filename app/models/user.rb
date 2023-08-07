class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :groups, dependent: :destroy
  has_many :comment_posts, dependent: :destroy

  enum role: { admin: 1, customer: 2 }

  validates :username, presence: true, uniqueness: true
  validate :check_amount_user_group, :check_amount_group 

  attr_accessor :login
  attr_accessor :group_ids

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def initialize(attributes = {})
      super(attributes)
      @group_ids = attributes[:group_ids]
  end

  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where(
      ["lower(username)= :value OR lower(email) = :value",{
        value: login.strip.downcase
      }]
    ).first
  end

  def check_amount_group
    errors.add(:users, 'can not add more than 5 group') if @group_ids && @group_ids.length >= 5
  end

  def check_amount_user_group
    return if !@group_ids
    group_counts = Group.where(id: group_ids).joins(:users).group('groups.id').count
    @group_ids.each do |group_id|
      if group_counts[group_id.to_i] >= 5
        errors.add(:Group, "Exists group has full size")
      end
    end
  end
end
