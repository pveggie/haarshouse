class Tune < ActiveRecord::Base
# == Constants ============================================================

# == Attributes ===========================================================

# == Extensions ===========================================================

# == Relationships ========================================================

# == Validations ==========================================================
  validates :game_title, presence: true
  validates :song_title, presence: true, uniqueness: { scope: :game_title,
             message: "This song has already been added." }
  validates :youtube_video_id, presence: true,
             uniqueness: { message: "This video has already been added." },
             format: {
                      with: /.*youtu.*[=\/]([\w-]*)/, message: "Please check your youtube link."
                    }

# == Scopes ===============================================================

# == Callbacks ============================================================
  before_save :extract_video_id_from_youtube_url
# == Class Methods ========================================================

# == Instance Methods =====================================================
  def extract_video_id_from_youtube_url
    self.youtube_video_id = youtube_video_id.match(/.*youtu.*[=\/]([\w-]*)/)[1]
  end

end
