class AdminPolicy < Struct.new(:user, :admin)

  def admin_recipes_index?
    user.admin?
  end
end