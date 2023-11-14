import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="init-videos"
export default class extends Controller {
  connect() {
    const youtubeApiUrl = "https://www.youtube.com/player_api";
    const youtubeScriptElement = document.createElement("script");
    youtubeScriptElement.src = youtubeApiUrl;

    document.body.append(youtubeScriptElement);
    $(".play-button").removeClass("hidden");
  }

  updateDisplayedViewCount(videoId, viewCount) {
    // Get element to be updated
    var viewCountElement = $("#view-count-" + videoId);
    // Get updated value of views
    var newViewCount = viewCount++;
    //Update views value
    viewCountElement.text(newViewCount);
  }

  play({ params }) {
    const { id: videoId, viewCount } = params;

    const onPlayerReady = (e) => {
      e.target.playVideo();
      this.updateDisplayedViewCount(videoId, viewCount);
    };

    new YT.Player(`video-${videoId}`, {
      videoId: videoId,
      playerVars: { autoplay: 1 },
      events: {
        onReady: onPlayerReady,
      },
    });
  }
}
