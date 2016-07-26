# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#recipes').imagesLoaded ->
    $('#recipes').masonry
      itemSelector: '.box'
      isFitWidth: true
$ ->
  $('#favorited-recipes').imagesLoaded ->
    $('#favorited-recipes').masonry
      itemSelector: '.box'
      isFitWidth: true
$ ->
  $('#users').imagesLoaded ->
    $('#users').masonry
      itemSelector: '.box'
      isFitWidth: true