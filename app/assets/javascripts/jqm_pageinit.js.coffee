$(document).on 'pageinit', ->

  $(document).on 'swiperight', $.mobile.activePage, (e) ->
    if $.mobile.activePage.jqmData('panel') isnt 'open'
      $('.nav-menu', $.mobile.activePage).panel 'open'