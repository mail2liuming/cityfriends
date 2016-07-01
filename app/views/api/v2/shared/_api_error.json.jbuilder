json.result do
  json.success false
  if @error
    json.message @error[:message]
    json.status @error[:status]
  end
end