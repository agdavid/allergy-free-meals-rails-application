
$(function() {

  // 'Show All Comments' link
  $('.js-loadComments').on('click', function(event) {
    event.preventDefault();
    var recipeId = $(event.target).data('id');
    var comments_html = '<ol class="recipeComments">'

    function Recipe(id, title, user, comments) {
      this.id = id
      this.title = title
      this.user = user
      this.comments = comments
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

  // 'Create Comment' button
  $('#new-comment-form').on("submit", function(event) {
    event.preventDefault();

    $.ajax({
      type: 'post', //($("input[name='_method']").val()  || this.method),
      url: this.action,
      data: $(this).serialize(),
      success: function() {
        $("input[name='comment[description]']").val(""); //empty new comment text area
        $('.js-loadComments').trigger('click');
      }
    });
  });

  // '[Comment]' show link
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
    };

    Comment.prototype.display_comment = function() {
        comment_html = comment_html.concat("<h2>" + this.user.name + " said about the " + this.recipe.title + "</h2><p>" + this.description + "</p><a href='/recipes/" + recipeId + "'>Back to Recipe</a>")
      };

    $.get("/recipes/" + recipeId + "/comments/" + commentId + ".json", function(data) {
      var comment = new Comment(data['id'], data['description'], data['recipe'], data['user']);
      comment.display_comment();
      $('#main-container').html(comment_html);
    });
    
  });
});