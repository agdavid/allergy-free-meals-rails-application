// JS to load comments - replaced by Remote True
// // Step 1: use jQuery document ready to load JS only when page loaded
// $(function () {
//   $("a.js-loadComments").on("click", function(event) {
//     // Step 2: Hijack the link to load all comments
//     // alert("You clicked the Show All Comments link!")
//     event.preventDefault();
//     // Step 3a: Fire low-level AJAX, get a response, load into DOM
//         // $.ajax({
//         //     method: "GET",
//         //     //url of "this", which is the href attribute of "Show All Comments" link
//         //     url: this.href, 
//         // }).success(function(response) {
//         //     //inject the plain comments#index response into DOM
//         //     $("div.comments-index").html(response);    
//         // });
//     // Step 3b: Fire higher-level AJAX, get a response, load into DOM
//         // $.get(this.href).success(function(response) {
//         //     $("div.comments-index").html(response);    
//         // });
//     // Step 3c: Fire AJAX and receive JSON response instead of HTML
//         // $.getJSON(this.href).success(function(json) {
//         //     var $ol = $("div.comments-index ol");
//         //     $ol.html(""); //clear the div for comments
//         //     json.forEach(function(comment) { //iterate over each json comment in array
//         //         //append each comment as <li> to the <ol>
//         //         $ol.append("<li>" + comment.description + "</li>");
//         //     });
//         // });
//     // Step 3d: Remote True paradigm for server-side AJAX
//         // $.ajax({
//         //     url: this.href,
//         //     dataType: "script",
//         // });
//   });
// });

// Step 1: use jQuery document ready to load JS only when page loaded
$(function() {
// JS to show comments without remote true in recipes#show
  $('.js-loadComments').on('click', function(click) {
    click.preventDefault();
    var recipeId = parseInt($(click['target']).attr("data-id"));
    debugger;
  });

// JS to post new comment via AJAX
  $('#new-comment-form').on("submit", function(event) {
    //Step 2: Hijack the form
    event.preventDefault();
    // Step 3a: Fire low-level AJAX, post to comments#create
      // data = {
      //   'authenticity_token': $("input[name='authenticity_token']").val(),
      //   'comment': {
      //     'description': $("input[name='comment[description]']").val(),
      //     'user_id': $("input[name='comment[user_id]']").val(),
      //     'recipe_id': $("input[name='comment[recipe_id]']").val()
      //   }
      // };
    $.ajax({
      type: ($("input[name='_method']").val()  || this.method), //generalize obtaining the action
      // method: "POST",
      url: this.action, //generalize getting the url
      data: $(this).serialize(), //generalize serializing the data
      success: function() {
        $("input[name='comment[description]']").val(""); //empty the text area
        $('div.comments-index').html(""); //empty the comments, if any
        $('a.js-loadComments').trigger('click'); //trigger "Show All Comments"
      }
    });
  });

// render comments_show page via jQuery and AMS JSON backend
  $('.comments-index').on('click', '.js-showComment', function(click) {
    // render response without page refresh
    click.preventDefault();
    var recipeId = parseInt($(click['target']).attr("recipe-id"));
    var commentId = parseInt($(click['target']).attr("comment-id"));
    var comment_html = ""

    // translate JSON into JS Model Object
    function Comment(id, description, recipe, user) {
      this.id = id 
      this.description = description 
      this.recipe = recipe 
      this.user = user
      // method on the prototype
      this.display_comment = function() {
        comment_html = comment_html.concat("<h2>" + this.user.name + " said about the " + this.recipe.title + "</h2><p>" + this.description + "</p><a href='/recipes/" + recipeId + "'>Back to Recipe</a>")
      }; 
    };

    // get JSON
    $.get("/recipes/" + recipeId + "/comments/" + commentId + ".json", function(data) {
      var comment = new Comment(data['id'], data['description'], data['recipe'], data['user']);
      comment.display_comment();
      $('#main-container').html(comment_html);
    });
    
  });
});