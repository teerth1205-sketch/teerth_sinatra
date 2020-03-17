class User < ActiveRecord::Base
  has_secure_password
 has_many :runs 
 has_many :friends
 has_many :rsvps
 has_many :events, through: :rsvps# add relationships here

 validates_uniqueness_of :username
 validates_presence_of :name, :username
end
