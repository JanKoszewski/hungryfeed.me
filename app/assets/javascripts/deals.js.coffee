
jQuery ->
  addHandlers()

  $(".iframe").colorbox({iframe:true, width:"80%", height:"80%"});

  $ ->

  $(".close_button").live "click", ->
    $.fn.colorbox.close()

  pusher = new Pusher("aafb6670cc00ac6045f1")
  deal_channel = pusher.subscribe("test_deals")
  deal_channel.bind "test_new_deal", (deal) ->
    if $("#deals").find($("#deal_"+ deal.id)).length
      tweetsColorer()
    else
      deal_id = 'deal_'+deal.id
      $("#deals").prepend("<div class='deal' id="+deal_id+"></div>")
      $("#"+deal_id).html(Mustache.to_html($("#deal_template").html(), deal))
      $("#"+deal_id+" .details").after("<div class='tweets' id=tweets_for_"+deal_id+"></div>")
      $("#tweets_for_"+deal_id).after(Mustache.to_html($("#deal_form_template").html(), deal))
      tweetsColorer()

  tweet_channel = pusher.subscribe("test_tweets")
  tweet_channel.bind "test_new_tweet", (tweet) ->
    if $("#deals").find($("#tweets_for_deal_"+ tweet.deal_id)).length
      new_tweet = $("#tweets_for_deal_"+tweet.deal_id).append(Mustache.to_html($("#tweet_template").html(), tweet))
      addTweetResponseHandler(tweet.id)
      if $("meta[name=current-user-name]").attr("content")
        $("#tweets_for_deal_"+tweet.deal_id+" #tweet-"+tweet.id+" .details").after "<a href=\"/tweet_responses/new." + tweet.id + "\" class=\"iframe btn btn-primary\" id=\"tweet_response\">Respond to tweet</a>"
        $(".iframe").colorbox
          iframe: true
          width: "80%"
          height: "80%"
    else
      console.log("deal not found!")

    if $("#deals").find($("#new_deal_email-"+tweet.deal_id)).length
      form = $("#deals").find($("#new_deal_email_"+tweet.deal_id))
      $(".deal #tweet-"+tweet.id).parent().after(form)
      tweetsColorer()
    else
      tweetsColorer()

  if $('#deals').length
    tweetsColorer()

tweetsColorer = ->
  scores = $("#deals .tweets").find($(".tweet .tweet_details .klout_score")).each ->
    if $(this).text() > 50  
      $(this).parent().parent().css('background','#47A3FF')
    else if $(this).text() > 40  
      $(this).parent().parent().css('background','#70B8FF')
    else if $(this).text() > 30
      $(this).parent().parent().css('background','#99CCFF')
    else if $(this).text() > 20
      $(this).parent().parent().css('background','#C2E0FF')
    else
      $(this).parent().parent().css('background-color', '#D6EBFF')

addHandlers = ->
  addTweetResponseHandler()

addTweetResponseHandler = ->
