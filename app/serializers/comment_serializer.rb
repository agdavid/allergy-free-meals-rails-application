class CommentSerializer < ActiveModel::Serializer
  attributes :id, :description, :user_id, :recipe_id
end
