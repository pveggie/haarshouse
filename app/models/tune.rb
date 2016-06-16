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
           uniqueness: { message: "This video has already been added." }

# validates :poster, presence: true

# == Scopes ===============================================================

# == Callbacks ============================================================

# == Class Methods ========================================================

# == Instance Methods =====================================================
end
