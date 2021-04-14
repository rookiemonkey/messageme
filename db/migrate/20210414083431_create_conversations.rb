class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.integer :user_one_id
      t.integer :user_two_id
      t.timestamps
    end
  end
end
