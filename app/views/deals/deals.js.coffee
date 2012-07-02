jQuery ->

  $(".iframe").colorbox({iframe:true, width:"80%", height:"80%"});

  $ ->

  pusher = new Pusher("<%= Pusher.key %>")
  deal_channel = pusher.subscribe("deals")
  deal_channel.bind "new_deal", (deal) ->
    if $("#deals").find($("#"+ deal.id)).length
      console.log("deal found!")
    else
      $("#deals").prepend(Mustache.to_html($("#deal_template").html(), deal))
      $("#deals .deal").first().append("</div>")
      $("#deals .deal").first().append(Mustache.to_html($("#deal_form_template").html(), deal))

  tweet_channel = pusher.subscribe("tweets")
  tweet_channel.bind "new_tweet", (tweet) ->
    if $("#deals").find($("#"+ tweet.deal_id)).length
      console.log("deal found from tweet!")
      new_tweet = $("#"+tweet.deal_id).append(Mustache.to_html($("#tweet_template").html(), tweet))
      if $("meta[name=current-user-name]").attr("content")
        $("#tweet-"+tweet.id+" .details").after "<a href=\"/tweet_responses/new." + tweet.id + "\" class=\"iframe btn btn-primary\" id=\"tweet_response\">Respond to tweet</a>"
        $(".iframe").colorbox
          iframe: true
          width: "80%"
          height: "80%"
      else
        $("#tweet-"+tweet.id+" .details").after "<a href=\"/auth/twitter\" class=\"btn btn-medium btn-primary\">Login with Twitter to reply!</a>"

    else
      console.log("cannot find deal!")

    if $("#deals").find($("#new_deal_email-"+tweet.deal_id)).length
      form = $("#deals").find($("#new_deal_email-"+tweet.deal_id))
      $(".deal #tweet-"+tweet.id).parent().after(form)
      console.log("form found!")
    else
      console.log("something went wrong!")
    
class DealsPager
  constructor: (@page = 1) ->
    $(window).scroll(@check)
  
  check: =>
    if @nearBottom()
      @page++
      $(window).unbind('scroll', @check)
      $.getJSON($('#deals').data('json-url'), page: @page, @render)

  nearBottom: =>
    $(window).scrollTop() > $(document).height() - $(window).height() - 50
    
  render: (deals) =>
    for deal in deals
      $('#deals').append Mustache.to_html($('#deal_template').html(), deal)
    $(window).scroll(@check) if deals.length > 0