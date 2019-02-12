class User < ActiveRecord::Base
  has_many :reviews
  has_many :coffee_shops, through: :reviews

  has_many :favorites 
  has_many :coffee_shops, through: :favorites  
end
