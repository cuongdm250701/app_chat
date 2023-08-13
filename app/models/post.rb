class Post < ApplicationRecord
    belongs_to :group
    has_many :comment_posts
    has_many :evaluates, as: :evaluate
end
