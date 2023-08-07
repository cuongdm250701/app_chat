class Group < ApplicationRecord
    has_and_belongs_to_many :users, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :posts, dependent: :destroy
    accepts_nested_attributes_for :users, allow_destroy: true, reject_if: :all_blank

    validates :name, uniqueness: true
    validate :limit_user, on: :create
    validate :check_name_users_duplicate, on: :create


    def self.check_amount_user user_ids
        if user_ids.length <= 5
            return true
        end
        return false
    end

    private

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
        if amount_users > 5
            errors.add(:users, 'can not add more than 5 user')
        end
    end

    # Sử dụng khi muốn check một số field cho phép rỗng mà vẫn muốn lưu cùng thằng cha
    # Mỗi lần gọi method này thì dữ liệu trong nested attributes
    # sẽ được truyền vào tham số attibutes để check dữ liệu
    # Tạo bao nhiêu user thì method này được gọi bấy nhiêu lần
    # def should_reject_user? attributes
    #     attributes[:username]
    #     return false
    # end

end