class Group < ApplicationRecord
    has_and_belongs_to_many :users, dependent: :destroy
    has_many :comments, dependent: :destroy
end