class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable 
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :user_allergens
  has_many :allergens, through: :user_allergens
end
