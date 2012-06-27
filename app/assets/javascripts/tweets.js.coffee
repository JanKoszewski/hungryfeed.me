# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  if $('#tweets').length
    new TweetsPager()
    
class TweetsPager
  constructor: (@page = 1) ->
    $(window).scroll(@check)
  
  check: =>
    if @nearBottom()
      @page++
      $(window).unbind('scroll', @check)
      $.getJSON($('#tweets').data('json-url'), page: @page, @render)

  nearBottom: =>
    $(window).scrollTop() > $(document).height() - $(window).height() - 50
    
  render: (tweets) =>
    for tweet in tweets
      $('#tweets').append Mustache.to_html($('#tweet_template').html(), tweet)
    $(window).scroll(@check) if tweets.length > 0