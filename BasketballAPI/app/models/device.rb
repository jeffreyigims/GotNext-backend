class Device < ApplicationRecord
    belongs_to :user

    validates :token, presence: true, uniqueness: true

    scope :for_user, -> (user_id) { where('user_id = ?', user_id) }
    scope :chronological, -> { order('updated_at DESC') }

end
