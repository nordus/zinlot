#= require jquery
#= require jquery_ujs
#= require jqm_custom
#= require jquery.mobile-1.3.1
#= require_tree .
#= require_self

$(document).on 'pageinit', ->

  $(document).on 'swiperight', $.mobile.activePage, (e) ->
    if $.mobile.activePage.jqmData('panel') isnt 'open'
      $('.nav-menu', $.mobile.activePage).panel 'open'
