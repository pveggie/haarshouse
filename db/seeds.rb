# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Tune.destroy_all

video_ids = ["RDqUAIQLQ-2OE", "8CP7TvaySew", "g5LdihtCspc",
"sToVooxkJGE", "eb6_J1dq1hk",




  "YV_jKDc1iow", "KopYyhmNirU", "u1nZMU1l0Os",
]

video_ids.each { |video_id| Tune.create(youtube_video_id: video_id)}
