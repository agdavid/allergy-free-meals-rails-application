$(function() {
  $('.js-showUserRecipes').on('click', function(event) {
    event.preventDefault();
    
    var userId = parseInt($(event.target).data('id'));
    var recipes_html = '';

    function User(id, name, recipes) {
      this.id = id
      this.name = name
      this.recipes = recipes
    };

    User.prototype.display_each_recipe = function() {
        $.each(this.recipes, function(i, recipe) {
          debugger;
          recipes_html = recipes_html.concat("<li><a href='/users/" + userId + "/recipes/" + recipe.id + "'>" + recipe.title + "</a></li>");
        });
      };

    $.get("/users/" + userId + ".json", function(data) {
      debugger;  
      var user = new User(data['id'], data['name'], data['recipes']);
      user.display_each_recipe();
      $('.userRecipes').html(recipes_html);  
    });

  });
});
  

