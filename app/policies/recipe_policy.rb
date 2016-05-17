class RecipePolicy < ApplicationPolicy

  def update?
    user.admin? || record.try(:user) == user
  end

  def destroy?
    user.admin? || record.try(:user) == user
  end

  def upvote?
    record.try(:user) != user
  end

  def downvote?
    record.try(:user) != user
  end

end