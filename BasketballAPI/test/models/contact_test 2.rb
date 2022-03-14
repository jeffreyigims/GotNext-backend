require 'test_helper'

class ContactTest < ActiveSupport::TestCase

  # Test relationships
  # should have_many(:players)

  # Test validations
  # Required field validations
  # should validate_presence_of(:email)
  # should validate_presence_of(:firstname)
  # should validate_presence_of(:lastname)
  # should validate_presence_of(:dob)
  # should validate_presence_of(:phone)

  # Username validations
  # should validate_uniqueness_of(:username).case_insensitive

  context "Given context" do
    setup do
      create_users
      create_contacts
    end

    teardown do
      destroy_users
      destroy_contacts
    end

    # should "create a " do
    #   assert_equal ["kobebryant", "lebronjames", "michaeljordan"], User.alphabetical_username.map{ |u| u.username }.sort
    # end

  end
end
