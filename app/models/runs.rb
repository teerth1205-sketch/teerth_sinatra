class Run < ActiveRecord::Base
  belongs_to :user
  
  validates :time, numericality: { greater_than: 0 }
  validates :miles, numericality: { greater_than: 0 }
  validates_presence_of :location, :date 
 
  
end
