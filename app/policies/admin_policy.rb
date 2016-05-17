class AdminPolicy < Struct.new(:user, :admin)

  # controllers/admin/recipes_controller
  def admin_recipes_index?
    user.admin?
  end

  # controllers/admin/allergens_controller
  def admin_allergens_index?
    user.admin?
  end

  def admin_allergens_new?
    admin_allergens_create?
  end

  def admin_allergens_create?
    user.admin?
  end

  def admin_allergens_edit?
    admin_allergens_update?
  end

  def admin_allergens_update?
    user.admin?
  end

  def admin_allergens_destroy?
    user.admin?
  end

end