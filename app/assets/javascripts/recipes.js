$(function() {
  $("#js-showUserRecipes").on("click", function(click) {
    click.preventDefault();
    var userId = parseInt($(click['target']).attr("data-id"));

    function User(id, name, recipes) {
      this.id = id
      this.name = name
      this.recipes = recipes
    };

    $.get("/users/" + userId + ".json", function(data) {  
      var user = new User(data['id'], data['name'], data['recipes']);
      debugger;  
    });

  });
});
  

