$(function () {
  $("a.js-loadComments").on("click", function(event) {
    // Step 1. Hijack the link to load all comments
    alert("You clicked the Show All Comments link!")
    event.preventDefault();
    // var newCommentText = $('#newCommentDescription').val();
    // var new_comment_html = "";

    // debugger;
    // $('.new-comment-show').toggle("hide");
    // //function NewComment(id, description, user, recipe)
  });
});
