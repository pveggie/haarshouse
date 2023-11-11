# # Model for youtube songs
# class Tune < ActiveRecord::Base
#   # == Constants ============================================================

#   # == Attributes ===========================================================

#   # == Extensions ===========================================================
#   include PgSearch::Model
#   # == Relationships ========================================================

#   # == Validations ==========================================================
#   validates :game_title, presence: true
#   validates :song_title,
#             presence: true,
#             uniqueness: {
#               scope: :game_title,
#               message: "This song has already been added."
#             }
#   # has to accept only the video id for update purposes
#   validates :youtube_video_id,
#             presence: true,
#             uniqueness: {
#               message: "This video has already been added."
#             },
#             format: {
#               with: /.*youtu.*[=\/]([\w-]*)|[\w|-]{11}/,
#               message: "Please check your youtube link."
#             }

#   # == Scopes ===============================================================
#   scope :by_date, -> { order(created_at: :desc) }
#   scope :by_game, -> { order(:game_title) }
#   scope :by_song, -> { order(:song_title) }
#   scope :most_viewed, -> { order(views: :desc) }

#   pg_search_scope :search,
#                   against: [:game_title, :song_title],
#                   using: {
#                     :tsearch => {
#                       prefix: true,
#                       dictionary: "english"
#                     },
#                   }

#   # == Callbacks ============================================================
#   before_save :extract_video_id_from_youtube_url
#   # == Class Methods ========================================================

#   # == Instance Methods =====================================================
#   def extract_video_id_from_youtube_url
#     # for update we just return what's already there
#     return if youtube_video_id =~ /^[\w-]{11}$/
#     self.youtube_video_id = youtube_video_id.match(/.*youtu.*[=\/]([\w-]*)/)[1]
#   end
# end
