if Rails.env.production?
  KLOUT_API_KEY = ENV["KLOUT_API_KEY"]
else
  KLOUT_API_KEY = "3aevewrwc7yej9x397mjx5c9"
end

Klout.api_key = KLOUT_API_KEY