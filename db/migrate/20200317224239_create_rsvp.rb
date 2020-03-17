class CreateRsvp < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.integer :user_id
      t.integer :event_id
    end 
  end
end
