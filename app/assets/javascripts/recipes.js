$(function() {
  $("#js-showUserRecipes").on("click", function(click) {
    click.preventDefault();
    var userId = parseInt($(click['target']).attr("data-id"));
    var recipes_html = ""

    function User(id, name, recipes) {
      this.id = id
      this.name = name
      this.recipes = recipes
      this.display_each_recipe = function() {
        alert("You are in the user prototype method!");
      };
    };

    $.get("/users/" + userId + ".json", function(data) {  
      var user = new User(data['id'], data['name'], data['recipes']);
      user.display_each_recipe();  
    });

  });
});
  

