class CreateUserContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_contacts do |t|
      t.references :user, foreign_key: true
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
