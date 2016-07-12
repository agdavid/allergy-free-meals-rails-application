// JS below to load comments - replaced by Remote True
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

// JS to post new comment via AJAX
// Step 1: use jQuery document ready to load JS only when page loaded
$(function() {
  $('#new-comment-form').on("submit", function(event) {
    //Step 2: Hijack the form
    alert("You submitted the form!");
    event.preventDefault();
  });
});