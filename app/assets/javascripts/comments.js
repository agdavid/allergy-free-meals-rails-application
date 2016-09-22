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

$(function() {
  $('.js-loadComments').on('click', function(event) {
    event.preventDefault();
    var recipeId = $(event.target).data('id');
    var comments_html = '<ol class="recipeComments">'

    function Recipe(id, title, user, comments) {
      this.id = id
      this.title = title
      this.user = user
      this.comments = comments
      // this.display_each_comment = function() {
      //   $.each(this.comments, function(i, comment) {
      //     comments_html = comments_html.concat("<li><a href='/recipes/" + recipeId + "/comments/" + comment.id + "' class='js-showComment' recipe-id='" + recipeId + "' comment-id='" + comment.id + "'>" + comment.description + "</a></li>")
      //   });
      //   comments_html = comments_html.concat('</ol>');
      // };
    };

    Recipe.prototype.display_each_comment = function() {
        $.each(this.comments, function(i, comment) {
          comments_html = comments_html.concat("<li><a href='/recipes/" + recipeId + "/comments/" + comment.id + "' class='js-showComment' recipe-id='" + recipeId + "' comment-id='" + comment.id + "'>" + comment.description + "</a></li>")
        });
        comments_html = comments_html.concat('</ol>');
      };

    $.get("/recipes/" + recipeId + ".json", function(data) {
      var recipe = new Recipe(data['id'], data['title'], data['user'], data['comments'])
      recipe.display_each_comment();
      $('.comments-index').html(comments_html)
    });
  });

  $('#new-comment-form').on("submit", function(event) {
    event.preventDefault();
      // data = {
      //   'authenticity_token': $("input[name='authenticity_token']").val(),
      //   'comment': {
      //     'description': $("input[name='comment[description]']").val(),
      //     'user_id': $("input[name='comment[user_id]']").val(),
      //     'recipe_id': $("input[name='comment[recipe_id]']").val()
      //   }
      // };
    $.ajax({
      // method: 'POST'
      type: ($("input[name='_method']").val()  || this.method),
      url: this.action,
      data: $(this).serialize(),
      success: function() {
        $("input[name='comment[description]']").val(""); //empty new comment text area
        $('.js-loadComments').trigger('click');
      }
    });
  });

  $('.comments-index').on('click', '.js-showComment', function(event) {
    event.preventDefault();
    var recipeId = $(event.target).attr('recipe-id');
    var commentId = $(event.target).attr('comment-id');
    var comment_html = ""

    function Comment(id, description, recipe, user) {
      this.id = id 
      this.description = description 
      this.recipe = recipe 
      this.user = user
      this.display_comment = function() {
        comment_html = comment_html.concat("<h2>" + this.user.name + " said about the " + this.recipe.title + "</h2><p>" + this.description + "</p><a href='/recipes/" + recipeId + "'>Back to Recipe</a>")
      }; 
    };

    $.get("/recipes/" + recipeId + "/comments/" + commentId + ".json", function(data) {
      var comment = new Comment(data['id'], data['description'], data['recipe'], data['user']);
      comment.display_comment();
      $('#main-container').html(comment_html);
    });
    
  });
});