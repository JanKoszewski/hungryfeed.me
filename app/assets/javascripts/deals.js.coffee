# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  if $('#deals').length
    new DealsPager()
    
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