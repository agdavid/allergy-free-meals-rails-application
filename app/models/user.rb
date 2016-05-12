class User < ActiveRecord::Base
  # Devise modules - others available:
  # :confirmable, :lockable, :timeoutable, :recoverable 
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :recipes

  has_many :user_allergens
  has_many :allergens, through: :user_allergens

  def self.find_or_create_from_omniauth(auth_hash)
    where(email: auth_hash[:info][:email]).first_or_create do |user|
      #set the remaining attributes
      user.name = auth_hash[:info][:name] 
      user.provider = auth_hash[:provider] 
      user.uid = auth_hash[:uid] 
    end
  end

  # If omniauth user not saved, sent back here from controller
  # Set the user attributes back on the model and validate
  def self.new_with_session(params, session)
    # If connect to omniauth provider
    if session["devise.user_attributes"]
      # Create new user from attributes, no protection because trust omniauth
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else # Fallback to normal Devise behavior
      super
    end
  end

  # Override method to avoid password during login, if from omniauth
  def password_required?
    # Require password only if omniauth provider is blank
    super && provider.blank?
  end

  # Override method to avoid password during edit/update, if from omniauth
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
