class UserContact < ApplicationRecord

  # Relationships
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :contact, :class_name => "Contact", :foreign_key => "contact_id"

  # Validations
#   validates_uniqueness_of :phone, scope: %i[user_id]

  # Scopes
#   scope :for_user, -> (user_id) { where('user_id = ?', user_id) }
#   scope :is_user, -> { joins(:user).where('user_id = ?', user_id) }
#   scope :for_favoritee, -> (favoritee_id) { where('favoritee_id = ?', favoritee_id) }
#   scope :alphabetical_favoritee, ->  { joins(:favoritee).order('firstname, lastname') }
#   scope :alphabetical_favoriter, ->  { joins(:favoriter).order('firstname, lastname') }

end
