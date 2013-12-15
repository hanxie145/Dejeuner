json.array!(@sms_contacts) do |sms_contact|
  json.id sms_contact.id 
  json.created_at sms_contact.created_at
end
