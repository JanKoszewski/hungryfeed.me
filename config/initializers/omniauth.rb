Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    TWITTER_ACCESS_TOKEN = ENV["TWITTER_ACCESS_TOKEN"]
    TWITTER_ACCESS_TOKEN_SECRET = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
  else
    TWITTER_ACCESS_TOKEN = "Am1DYDJiFoautwZJ7MXcXg"
    TWITTER_ACCESS_TOKEN_SECRET = "dTjN7CrRnk80gF5nj3nlchMbgpSkAHGji8SopUhwo" 
  end
  provider :twitter, TWITTER_ACCESS_TOKEN, TWITTER_ACCESS_TOKEN_SECRET
end