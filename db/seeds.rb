# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Tune.destroy_all

videos = [
  { video_id: '8CP7TvaySew', game_title: 'Rayman Legends', song_title: 'Orchestral Chaos' },
  { video_id: 'g5LdihtCspc', game_title: 'Tales of Symphonia', song_title: 'Anchoret' },
  { video_id: 'sToVooxkJGE', game_title: 'Fire Emblem: Radiant Dawn', song_title: 'Eternal Bond' },
  { video_id: 'eb6_J1dq1hk', game_title: 'Mass Effect 2', song_title: 'Suicide Mission' },
  { video_id: 'YV_jKDc1iow', game_title: 'Brutal Legend', song_title: 'Girlfriend (Kabbage Boy)' },
  { video_id: 'u1nZMU1l0Os', game_title: 'Remember Me', song_title: 'Still Human' }
]

videos.each do |video|
  Tune.create!(youtube_video_id: video[:video_id],
               game_title: video[:game_title],
               song_title: video[:song_title])
end
