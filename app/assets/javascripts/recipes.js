$(function() {
  $('.js-showUserRecipes').on('click', function(event) {
    event.preventDefault();
    
    var userId = parseInt($(event.target).data('id'));
    var recipesHTML = '';

    // Revised AJAX get request to Recipes index of a User
    $.ajax({
      type: 'GET',
      url: '/users/' + userId + '/recipes.json',
      success: function(data) {
        showRecipes(data)  
      } 
    });

    function showRecipes(data) {
      for ( var i = 0; i < data.length; i++) {
        var recipe = new Recipe(data[i].id, data[i].title, data[i].user.id);
        recipe.displayRecipe();
        $('.userRecipes').html(recipesHTML)
      }
    };

    function Recipe(id, title, user_id) {
      this.id = id
      this.title = title
      this.user_id = user_id
    };

    Recipe.prototype.displayRecipe = function() {
      recipesHTML = recipesHTML.concat('<li><a href="/users/' + this.user_id+ '/recipes/' + this.id + '">' + this.title + '</a></li>');
    };

    
    // Previous AJAX get request for a User instance with many Recipes
      // function User(id, name, recipes) {
      //   this.id = id
      //   this.name = name
      //   this.recipes = recipes
      // };

      // User.prototype.display_each_recipe = function() {
      //     $.each(this.recipes, function(i, recipe) {
      //       debugger;
      //       recipes_html = recipes_html.concat("<li><a href='/users/" + userId + "/recipes/" + recipe.id + "'>" + recipe.title + "</a></li>");
      //     });
      //   };

      // $.get("/users/" + userId + ".json", function(data) {
      //   debugger;  
      //   var user = new User(data['id'], data['name'], data['recipes']);
      //   user.display_each_recipe();
      //   $('.userRecipes').html(recipes_html);  
      // });

  });
});
  

