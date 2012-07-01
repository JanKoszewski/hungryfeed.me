# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120701172559) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.integer  "uid"
    t.string   "access_token"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "authentications", ["access_token"], :name => "index_authentications_on_access_token"
  add_index "authentications", ["uid"], :name => "index_authentications_on_uid"
  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "deal_emails", :force => true do |t|
    t.integer  "tweet_id"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "link"
    t.integer  "deal_id"
  end

  add_index "deal_emails", ["deal_id"], :name => "index_deal_emails_on_deal_id"
  add_index "deal_emails", ["link"], :name => "index_deal_emails_on_link"
  add_index "deal_emails", ["tweet_id"], :name => "index_deal_emails_on_tweet_id"

  create_table "deals", :force => true do |t|
    t.string   "link"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
    t.integer  "purchased"
  end

  add_index "deals", ["link"], :name => "index_deals_on_link"
  add_index "deals", ["purchased"], :name => "index_deals_on_purchased"

  create_table "tweet_responses", :force => true do |t|
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "tweet_id"
  end

  add_index "tweet_responses", ["tweet_id"], :name => "index_tweet_responses_on_tweet_id"
  add_index "tweet_responses", ["user_id"], :name => "index_tweet_responses_on_user_id"

  create_table "tweets", :force => true do |t|
    t.string   "content"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "twitter_username"
    t.string   "twitter_user_image"
    t.integer  "deal_id"
    t.integer  "user_id"
    t.string   "link"
  end

  add_index "tweets", ["deal_id"], :name => "index_tweets_on_deal_id"
  add_index "tweets", ["twitter_username"], :name => "index_tweets_on_twitter_username"
  add_index "tweets", ["user_id"], :name => "index_tweets_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.string   "twitter_link"
    t.string   "twitter_username"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "klout_score"
    t.string   "oauth_token"
    t.string   "oauth_token_secret"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"
  add_index "users", ["twitter_username"], :name => "index_users_on_twitter_username"

end
