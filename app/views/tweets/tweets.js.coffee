# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  $(".iframe").colorbox({iframe:true, width:"80%", height:"80%"});

  $ ->

  pusher = new Pusher("<%= Pusher.key %>")
  tweet_channel = pusher.subscribe("tweets")
  tweet_channel.bind "new_tweet", (tweet) ->
    console.log(tweet)
    new_tweet = $("#tweets").prepend(Mustache.to_html($("#tweet_template").html(), tweet))
    if $("meta[name=current-user-name]").attr("content")
      $(".tweet").first().append "<a href=\"/tweet_responses/new." + tweet.id + "\" class=\"iframe btn btn-primary\" id=\"tweet_response\">Respond to tweet</a>"
      $(".iframe").colorbox
        iframe: true
        width: "80%"
        height: "80%"
    else
      $(".tweet").first().append "<a href=\"/auth/twitter\" class=\"btn btn-medium btn-primary\">Login with Twitter to reply!</a>"
    tweetsColorer()

  user_channel = pusher.subscribe("users")
  user_channel.bind "new_user", (user) ->
    user_score = $("#tweets").find($(".tweet h2 a")).each ->
    if $(this).text() == user.twitter_username
      $(this).parent().$(".klout_score").val(user.klout_score)
    tweetsColorer()

  if $('#tweets').length
    new TweetsPager()
    tweetsColorer()
       
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
      tweetsColorer()
    $(window).scroll(@check) if tweets.length > 0
    $(".iframe").colorbox({iframe:true, width:"80%", height:"80%"});

tweetsColorer = ->
  scores = $("#tweets").find($(".tweet .details .klout_score")).each ->
    if $(this).text() > 20
      $(this).parent().parent().css('background','#FA5858')
    else
      $(this).parent().parent().css('background-color', '#00FF00')