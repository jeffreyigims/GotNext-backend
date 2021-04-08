class ContactsSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :firstName, :lastName, :phone
  end
  