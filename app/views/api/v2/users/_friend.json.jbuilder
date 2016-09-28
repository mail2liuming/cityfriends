
if friend.user_id != @user.id
    json.id friend.user.id
    json.name friend.user.name
elsif friend.positive_user_id != @user.id
    json.id friend.positive_user.id
    json.name friend.positive_user.name
end