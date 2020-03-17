class CreateRun < ActiveRecord::Migration
  def change 
    create_table :runs do |t|
      t.integer :time
      t.integer :miles
      t.string :location
      t.string :date 
      t.integer :user_id
    end 
  end 
end 