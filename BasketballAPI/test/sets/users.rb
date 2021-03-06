module Contexts
  module Users

    def create_users
      @user1 = FactoryBot.create(:user, username: "michaeljordan", email: "michaeljordan@gmail.com", firstname: "Michael", lastname: "Jordan", dob: 10.years.ago.to_date, password: "secret", password_confirmation: "secret")
      @user2 = FactoryBot.create(:user, username: "kobebryant", email: "kobebryant@gmail.com", firstname: "Kobe", lastname: "Bryant", phone: "1235432365", dob: 12.years.ago.to_date)
      @user3 = FactoryBot.create(:user, username: "lebronjames", email: "lebronjames@gmail.com", firstname: "LeBron", lastname: "James", phone: "4122346547", dob: 14.years.ago.to_date)
    end

    def destroy_users
      @user1.destroy
      @user2.destroy
      @user3.destroy
    end
  end
end