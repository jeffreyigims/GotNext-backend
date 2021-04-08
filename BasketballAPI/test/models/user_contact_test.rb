require 'test_helper'

class ContactUserTest < ActiveSupport::TestCase

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
      destroy_contacts
      destroy_users
    end

    should "create a user_contact when a user with a phone number in contacts is added" do
      @scurry = FactoryBot.create(:user, username: "scurry", phone: "4327587483")
      @user_contact = @scurry.user_contacts.first
      assert_equal @user_contact.user, @scurry 
      assert_equal @user_contact.contact, @contact1 
      assert_equal @user_contact.contact.user, @user3 
      @user_contact.destroy
      @scurry.destroy
    end

    should "create a user_contact when a contact with a phone number in users is added" do
      @kbryant = FactoryBot.create(:contact, firstName: "Kobe", lastName: "Bryant", phone: "1235432365", user: @user3)
      @user_contact = @kbryant.user_contacts.first
      assert_equal @user_contact.user, @user2 
      assert_equal @user_contact.contact, @kbryant 
      @user_contact.destroy
      @kbryant.destroy
    end

  end
end
