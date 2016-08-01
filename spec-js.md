# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements

- [x] Include a show page rendered using jQuery and an Active Model Serialization JSON backend.
  - from recipes#show (e.g., /recipes/2) click on "Show All Comments" which renders comments#index (e.g., /recipes/2/comments), and from there click on comments#show link (e.g., /recipes/2/comments/1) to render comment through jQuery in javascripts/comments.js

- [x] Include an index page rendered using jQuery and an Active Model Serialization JSON backend.
  - from users#show (e.g., /users/1) click on "Show Contributed Recipes" which renders the nested resource recipes#index (e.g., /users/1/recipes) through jQuery in javascripts/recipes.js

- [x] Include at least one has_many relationship in information rendered via JSON
  - the AMS in serializers/user_serializer.rb reveals a user has_many recipes. This is used in the user method on the prototype #display_each_recipe in javascripts/recipes.js

- [ ] Include at least one link that loads or updates a resource without reloading the page
  - [TBD]

- [x] Translate JSON responses into js model objects
  - the JSON response for user is translated into a User JS model object, including a has_many recipes relationship
  - the JSON response for comment is translated into a Comment JS model object

- [x] At least one of the js model objects must have at least one method added by your code to the prototype
  - the User JS model object has #display_each_recipe
  - the Comment JS model object has #display_comment

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
