if @user
  json.(feed,:id,:feed_type,:start_time,:start_place,:end_place,:end_time,:feed_content,:user_id)
  json.user_name feed.user.name
else
  json.(feed,:id,:feed_type,:start_time,:start_place,:end_place,:end_time,:feed_content)
end

