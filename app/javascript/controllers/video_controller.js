import { Controller } from "@hotwired/stimulus";
import { fetchRails } from "../helpers/railsRequest";

// Connects to data-controller="init-videos"
export default class extends Controller {
  static targets = ["viewCount"];
  connect() {
    const youtubeApiUrl = "https://www.youtube.com/player_api";
    const youtubeScriptElement = document.createElement("script");
    youtubeScriptElement.src = youtubeApiUrl;

    document.body.append(youtubeScriptElement);
    $(".play-button").removeClass("hidden");
  }

  async updateViewCount(id, youtubeId) {
    const response = await fetchRails(`/tunes/${id}/increment_views`, {
      method: "patch",
    });

    var viewCountElement = this.viewCountTargets.find(
      (k) => k.id === `view-count-${youtubeId}`
    );

    if (response && response.views && viewCountElement) {
      viewCountElement.innerHTML = response.views;
    }
  }

  play({ params }) {
    const { id, youtubeId } = params;

    const onPlayerReady = (e) => {
      e.target.playVideo();
      this.updateViewCount(id, youtubeId);
    };

    new YT.Player(`youtube-placeholder-${youtubeId}`, {
      videoId: youtubeId,
      playerVars: { autoplay: 1 },
      events: {
        onReady: onPlayerReady,
      },
    });
  }
}
