json.array!(@signup_emails) do |signup_email|
  json.extract! signup_email, :email, :description
  json.url signup_email_url(signup_email, format: :json)
end
