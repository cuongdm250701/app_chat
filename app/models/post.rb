class Post < ApplicationRecord
    belongs_to :group
    has_many :comment_posts
end
