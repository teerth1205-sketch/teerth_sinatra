class CreateEvents < ActiveRecord::Migration
  def change 
    create_table :events do |t|
      t.string :date
      t.string :time 
      t.string :location
      t.string :description 
    end 
  end 
end 