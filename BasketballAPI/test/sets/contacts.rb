module Contexts
    module Contacts
  
      def create_contacts
        @contact1 = FactoryBot.create(:contact, firstName: "Steph", lastName: "Curry", phone: "4327587483", user: @user3)
        @contact2 = FactoryBot.create(:contact, firstName: "Rajon", lastName: "Rondo", phone: "7483847584", user: @user3)
        @contact3 = FactoryBot.create(:contact, firstName: "Kyrie", lastName: "Irving", phone: "2738485968", user: @user3)
      end
  
      def destroy_contacts
        @contact1.destroy
        @contact2.destroy
        @contact3.destroy
      end
    end
  end