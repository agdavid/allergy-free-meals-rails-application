class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_one :user
  has_many :comments
end
