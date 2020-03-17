class Event < ActiveRecord::Base
 #attr_accessor :name, :location, :description
 has_many :rsvps
 has_many :users, through: :rsvps# add relationships here
 validates_presence_of :time, :location, :description, :date
end
