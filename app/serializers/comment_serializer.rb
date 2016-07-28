class CommentSerializer < ActiveModel::Serializer
  attributes :id, :description, :user_id, :recipe_id
  has_one :recipe
  has_one :user
end
