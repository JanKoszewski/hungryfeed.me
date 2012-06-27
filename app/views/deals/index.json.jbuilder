json.deals @deals do |json, deal|
  json.partial! deal
  json.tweets deal.tweets do |json, tweet|
  	json.partial! tweet
  end
end