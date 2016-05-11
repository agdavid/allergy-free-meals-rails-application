class AddAuthorIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :author_id, :integer
  end
end
