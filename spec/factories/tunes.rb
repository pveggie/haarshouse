FactoryBot.define do
  factory :tune do |f|
    f.game_title { 'Dragon Age 2' }
    f.song_title { 'Fenris Theme' }
    f.youtube_video_id { 'youtube.com/watch?v=dSCq7jTL7tQ' }

    # factory :user_tune do |g|
    #   g.game_title { 'User tune game title' }
    #   g.song_title { 'User tune song title' }
    #   g.youtube_video_id { 'youtube.com/watch?v=dSCq7jTL7tQ' }
    #   g.user_id { create(:user)[:id] }
    # end
  end
end
