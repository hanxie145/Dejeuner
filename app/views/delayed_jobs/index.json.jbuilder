json.array!(@scheduled_messages) do |scheduled_message|
  json.id scheduled_message.id
  json.user_id scheduled_message.user_id
  json.run_at do
    json.year scheduled_message.run_at.year
    json.month scheduled_message.run_at.month
    json.day scheduled_message.run_at.day
    json.hour scheduled_message.run_at.hour
    json.minute scheduled_message.run_at.min
  end
  message = scheduled_message.handler.split('args').last
  json.message message.slice(4, message.length)
end
