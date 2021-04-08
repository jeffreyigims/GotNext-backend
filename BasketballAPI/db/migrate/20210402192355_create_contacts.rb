class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :firstName
      t.string :lastName
      t.string :phone
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
