class Run < ActiveRecord::Base
  belongs_to :user
  
  validates :time, numericality: { greater_than: 0 }
  validates :miles, numericality: { greater_than: 0 }
  validates_presence_of :location, :date 
  def pace
    @pace ||= time/miles.to_f
  end
  def ms
  "%02d:%02d" % [pace.floor, (pace % 1 * 60).floor]
  end
end
