class User < ActiveRecord::Base
  # Devise modules - others available:
  # :confirmable, :lockable, :timeoutable, :recoverable 
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  # Relationships
  has_many :recipes
  has_many :favorite_recipes
  has_many :favorites, through: :favorite_recipes, source: :recipe

  has_many :user_allergens
  has_many :allergens, through: :user_allergens

  
  # Oauth
  def self.find_or_create_from_omniauth(auth_hash)
    where(email: auth_hash[:info][:email]).first_or_create do |user|
      #set the remaining attributes
      user.name = auth_hash[:info][:name] 
      user.provider = auth_hash[:provider] 
      user.uid = auth_hash[:uid] 
    end
  end

  
  # Devise overrides
  # If oauth user not saved, sent here from controller
  # Set user attributes back on the model and validate
  def self.new_with_session(params, session)
    # If connect to oauth provider
    if session["devise.user_attributes"]
      # Create new user from attributes, no protection because trust oauth
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else # Fallback to default Devise behavior
      super
    end
  end

  # Override to avoid password during login, if from oauth
  def password_required?
    # Fallback to default Devise behavior
    # Require password only if oauth provider blank
    super && provider.blank?
  end

  # Override to avoid password during edit/update, if from oauth
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      # Fallback to default Devise behavior
      # Require password confirmation if user has encrypted password
      super
    end
  end
end
