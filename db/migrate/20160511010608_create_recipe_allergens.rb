class CreateRecipeAllergens < ActiveRecord::Migration
  def change
    create_table :recipe_allergens do |t|
      t.integer :allergen_id
      t.integer :recipe_id

      t.timestamps null:false
    end
  end
end
