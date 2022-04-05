class UserContact < ApplicationRecord

  # Relationships
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :contact, :class_name => "Contact", :foreign_key => "contact_id"

  validate :unique_phone

  scope :alphabetical, ->  { joins(:user).order('firstname, lastname') }

  def unique_phone
    if self.contact.user.phone == self.contact.phone
      errors.add(:profile_id, "[INFO] duplicate phone report")
    end
  end

end
