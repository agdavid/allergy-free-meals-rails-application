$(function() {
  // render user_recipes index page via jQuery and an Active Model Serialization JSON Backend
  $(".js-showUserRecipes").on("click", function(click) {
    // render response without page refresh
    click.preventDefault();
    var userId = parseInt($(click['target']).attr("data-id"));
    var recipes_html = ""

    // translate JSON into JS Model Object
    function User(id, name, recipes) {
      this.id = id
      this.name = name
      this.recipes = recipes
      // method on the prototype
      this.display_each_recipe = function() {
        // reveal has_many relationship of prototype
        $.each(this.recipes, function(i, recipe) {
          recipes_html = recipes_html.concat("<li><a href='/users/" + userId + "/recipes/" + recipe.id + "'>" + recipe.title + "</a></li>") // TO MAKE STRING OF RECIPES and LINKS
        });
      };
    };

    // get JSON
    $.get("/users/" + userId + ".json", function(data) {  
      var user = new User(data['id'], data['name'], data['recipes']);
      user.display_each_recipe();
      $('.userRecipes').html(recipes_html);  
    });

  });
});
  

