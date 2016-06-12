// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$( document ).ready(function() {

  // Load the IFrame Player API code asynchronously.
  var tag = document.createElement('script');
  tag.src = "https://www.youtube.com/player_api";
  var firstScriptTag = document.getElementsByTagName('script')[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

  // Replace the 'video' element with an <iframe> and
  // YouTube player after the API code downloads.
  var player;

  function playVideo (videoId) {
    player = new YT.Player(videoId, {
      videoId: videoId,
      autoplay: 1,
      events: {
            'onReady': onPlayerReady,
            // 'onStateChange': onPlayerStateChange
          }

    });
  }

  function onPlayerReady(event) {
    event.target.playVideo();
  }

  // var done = false;
  //     function onPlayerStateChange(event) {
  //       if (event.data == YT.PlayerState.PLAYING && !done) {
  //         setTimeout(stopVideo, 6000);
  //         done = true;
  //       }
  //     }
  //     function stopVideo() {
  //       player.stopVideo();
  //     }



  // Listen out for clicks on play buttons and get id of video
  $('.play-button').click(function() {
    var videoId = $( this ).data('video-id');
    console.log(videoId);
    $('.play-button').removeClass('hidden')
    $( this ).addClass('hidden')
    playVideo(videoId);
  })
});
