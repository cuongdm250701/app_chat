class Evaluate < ApplicationRecord
    belongs_to :evaluate, polymorphic: true
    belongs_to :user
end
