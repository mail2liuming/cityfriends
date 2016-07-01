if @user
  json.(feed,:id,:feed_type,:start_time,:start_place,:end_place,:end_time,:available,:user_id,:user_name)
else
  json.(feed,:id,:feed_type,:start_time,:start_place,:end_place,:end_time,:available)
end

