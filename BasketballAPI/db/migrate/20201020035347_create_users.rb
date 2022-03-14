class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :apple
      t.string :username
      t.string :email
      t.string :firstname
      t.string :lastname
      t.date :dob
      t.string :phone

      t.timestamps
    end
  end
end
