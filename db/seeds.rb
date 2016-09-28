# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")
             
User.create!(name:  "Example User2",
             email: "example2@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")
             
User.create!(name:  "Example User3",
             email: "example3@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")
             
users = User.order(:created_at).take(3)

5.times do
    users.each do |user|
        feed = user.feeds.create!(start_place:"hongkong",start_time:"2016-6-10",end_place:"auckland",end_time:"2016-6-29",feed_type: Feed::TYPE_PROVIDER,feed_content:"5kg available")
        user.calendars.create!(feed_id: feed.id,calendar_type: Calendar::TYPE_OWNER, exact_time:"2016-6-11")
        int id = user.id == 3? 1: (user.id+1)
        user.sending_messages.create!(receiver_id: id,msg_type: 1,msg_content: "add friend")
    end
end
