# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  
  $(".iframe").colorbox({iframe:true, width:"80%", height:"80%"});

  swapFailedToLoadImage: (img) ->
    $(img).attr('src', "/image_not_found.jpeg")

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
      new_tweet = $('#tweets').append Mustache.to_html($('#tweet_template').html(), tweet)
      if $("meta[name=current-user-name]").attr("content")
        $(new_tweet).append('<a href="/tweet_responses/new.'+tweet.id+'" class="iframe btn btn-primary" id="tweet_response">Respond to tweet</a>')
      else
        $(new_tweet).append('<a href="/auth/twitter" class="btn btn-medium btn-primary">Login with Twitter to reply!</a>')
    $(window).scroll(@check) if tweets.length > 0
    $(".iframe").colorbox({iframe:true, width:"80%", height:"80%"});