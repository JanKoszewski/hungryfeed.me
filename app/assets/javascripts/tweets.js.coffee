
jQuery ->

  $(".iframe").colorbox({iframe:true, width:"80%", height:"80%"});

  $ ->

  pusher = new Pusher("aafb6670cc00ac6045f1")
  tweet_channel = pusher.subscribe("tweets")
  tweet_channel.bind "new_tweet", (tweet) ->
    new_tweet = $("#tweets").prepend(Mustache.to_html($("#tweet_template").html(), tweet))
    $(".iframe").colorbox
      iframe: true
      width: "80%"
      height: "80%"
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
      tweetsColorer()
    $(window).scroll(@check) if tweets.length > 0
    $(".iframe").colorbox({iframe:true, width:"80%", height:"80%"});

tweetsColorer = ->
  scores = $("#tweets").find($(".tweet .tweet_details .tweet_klout_score")).each ->
    if $(this).text() >= 50  
      $(this).parent().parent().css('background','#47A3FF')
    else if $(this).text() >= 40  
      $(this).parent().parent().css('background','#70B8FF')
    else if $(this).text() >= 30
      $(this).parent().parent().css('background','#99CCFF')
    else if $(this).text() >= 20
      $(this).parent().parent().css('background','#C2E0FF')
    else
      $(this).parent().parent().css('background-color', '#EBF5FF')