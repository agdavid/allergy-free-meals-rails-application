Flash Notices Default Code: 
  <%= content_tag(:div, flash[:error], :id => "flash_error") if flash[:error] %>
  <%= content_tag(:div, flash[:notice], :id => "flash_notice") if flash[:notice] %>
  <%= content_tag(:div, flash[:alert], :id => "flash_alert") if flash[:alert] %>

Fix for Glyphicon Heroku Bug:
- config/environment/production.rb
  - config.assets.compile = true #<= defaults to false; change to true

Intersection of User allergens and Recipe allergens
  - get all recipes
  - iterate over each recipe (each do)
    - check intersection of user.allergens and recipe.allergens
    - if intersection == user.allergens (array1 & array2)
    - push recipe into collection