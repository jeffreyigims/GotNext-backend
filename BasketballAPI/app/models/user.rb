class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_secure_password

  # Relationship
  # has_one_attached :image
  has_one_base64_attached :image
  has_many :players
  has_many :contacts
  has_many :user_contacts, through: :contacts

  # Validations
  validates_presence_of :email, :firstname, :lastname, :dob, :phone 
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_presence_of :password, :on => :create
  validates_presence_of :password_confirmation, :on => :create
  validates_confirmation_of :password, message: "password does not match"
  validates_length_of :password, :minimum => 6, message: "password must be at least 6 characters long"
  validates_date :dob, before: :today
  validates_uniqueness_of :phone
  validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format", allow_blank: true

  # Scopes
  scope :alphabetical_username, -> { order('username') }
  scope :alphabetical_name, -> { order('lastname, firstname') }
  scope :search, ->(term) { where('LOWER( firstname ) LIKE ? OR LOWER( lastname ) LIKE ? OR LOWER( username ) LIKE ?', "#{term}%", "#{term}%", "#{term}%") }
  scope :for_phone, ->(phone) { where('phone = ?', phone) }

  def games
    self.players.map{ |p| Game.chronological.find(p.game_id) }.sort_by { |g| [g.date, g.time] }
  end

  def get_image_url
    self.image.attached? ? url_for(self.image) : nil
  end

  # login by username
  def self.authenticate(username, password)
    find_by_username(username).try(:authenticate, password)
  end

  # callback that generates the API key
  before_create :generate_api_key
  after_save :search_contacts, :on => :create

  private
  def generate_api_key
    begin
      self.api_key = SecureRandom.hex
    end while User.exists?(api_key: self.api_key)
  end

  def search_contacts 
    @contacts = Contact.for_phone(self.phone)
    @contacts.map { |contact|
      UserContact.new(:user => self, :contact => contact).save
    }
  end 

end
