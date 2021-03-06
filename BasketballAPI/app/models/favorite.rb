class Favorite < ApplicationRecord
  # Relationships
  belongs_to :favoriter, :class_name => "User", :foreign_key => "favoriter_id"
  belongs_to :favoritee, :class_name => "User", :foreign_key => "favoritee_id"

  # Validations
  validates_presence_of :favoriter_id, :favoritee_id
  validates_uniqueness_of :favoriter_id, scope: %i[favoritee_id]

  # Scopes
  scope :for_favoriter, -> (favoriter_id) { where('favoriter_id = ?', favoriter_id) }
  scope :for_favoritee, -> (favoritee_id) { where('favoritee_id = ?', favoritee_id) }
  scope :for_users, ->  (favoriter_id, favoritee_id) { where('favoriter_id = ? AND favoritee_id = ?', favoriter_id, favoritee_id) }
  scope :alphabetical_favoritee, ->  { joins(:favoritee).order('firstname, lastname') }
  scope :alphabetical_favoriter, ->  { joins(:favoriter).order('firstname, lastname') }

end
