# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  $(".iframe").colorbox({iframe:true, width:"80%", height:"80%"});

  $ ->
  faye = new Faye.Client("http://localhost:9292/faye")

  faye.subscribe "/deals/new", (deal) ->
    if $("#deals").find($("#"+ deal.id)).length
      console.log("deal found!")
    else
      new_deal = $("#deals").prepend(Mustache.to_html($("#deal_template").html(), deal))
      new_deal.append(Mustache.to_html($("#deal_form_template").html(), deal))

  faye.subscribe "/tweets/new", (tweet) ->
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

    if $("#"+ tweet.deal_id).find($("form")).length
      form = $("#"+ tweet.deal_id).find($("form"))
      form.detach()
      form.insertAfter($("#"+ tweet.deal_id+" .tweet:last-child"))
      console.log("Form moved!")
    else
      console.log("Something went wrong!")
      
    
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