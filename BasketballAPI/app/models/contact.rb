class Contact < ApplicationRecord

  # Relationships
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  has_many :user_contacts

  # Validations
  validates_uniqueness_of :phone, scope: %i[user_id]

  # Scopes
  scope :for_user, -> (user_id) { where('user_id = ?', user_id) }
  scope :is_user, -> { joins(:user).where('user_id = ?', user_id) }
  scope :for_phone, ->(phone) { where('phone = ?', phone) }
  scope :not_user, -> { left_outer_joins(:user_contacts).where('user_contacts.user_id IS NULL') }
  scope :alphabetical_name, -> { order('"firstName", "lastName"') }

after_save :search_users, :on => :create

private
def search_users 
    @users = User.for_phone(self.phone)
  @users.map { |user| 
    UserContact.new(:user => user, :contact => self).save
  }
end 

end
