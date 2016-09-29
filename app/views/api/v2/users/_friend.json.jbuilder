
if friend.user_id != @user.id
    json.id friend.user.id
    json.name friend.user.name
    json.email friend.user.email
elsif friend.positive_user_id != @user.id
    json.id friend.positive_user.id
    json.name friend.positive_user.name
    json.email friend.positive_user.email
end