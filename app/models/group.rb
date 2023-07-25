class Group < ApplicationRecord
    has_and_belongs_to_many :users, dependent: :destroy
    has_many :comments, dependent: :destroy
    accepts_nested_attributes_for :users, allow_destroy: true

    validates :name, uniqueness: true
    validate :limit_user, :check_name_users_duplicate

    def check_name_users_duplicate
        list_emails = users.map do |user|
            user[:email]
        end
        list_username = users.map do |user|
            user[:username]
        end
        emails_exists = list_emails.length == list_emails.uniq.length
        username_exists = list_username.length == list_username.uniq.length
        if !emails_exists || !username_exists
            errors.add(:users, 'can not duplicate email or username')
        end
    end

    def limit_user
        amount_users = users.length
        if amount_users > 3
            errors.add(:users, 'can not add more than 2 user')
        end
    end
end