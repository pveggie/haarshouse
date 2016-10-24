// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$( document ).ready(function() {

  // Load the IFrame Player API code asynchronously.
  // Playing videos is handled in the AJAX request form
  // views/tunes/show.js.erb
  var tag = document.createElement('script');

  tag.src = "https://www.youtube.com/player_api";
  var firstScriptTag = document.getElementsByTagName('script')[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
  $('.play-button').removeClass('hidden');

  $('#searchButtonMobile').click(function(){
    $('#searchBoxMobile').removeClass('hidden');
  });

  $('#sortOptions').click(function(){
    $('#searchBoxMobile').addClass('hidden');
  });

  $('.video-grid').click(function(){
    $('#searchBoxMobile').addClass('hidden');
  });
});
