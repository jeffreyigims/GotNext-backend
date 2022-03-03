class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.references :user, index: true, foreign_key: true
      t.string :token
      t.string :platform
      t.timestamps
    end
  end
end
