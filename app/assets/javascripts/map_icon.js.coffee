@mapIcon = (eventCode, speed) ->
  eventCode = String(eventCode)
  iconUrl   = switch eventCode
    when '20' then _.template("https://mts.googleapis.com/vt/icon/name=icons/spotlight/spotlight-waypoint-a.png&text=<%= text %>&psize=13&font=fonts/Roboto-Regular.ttf&color=<%= color %>&ax=44&ay=51&scale=1")
    when '30' then _.template("https://mts.googleapis.com/vt/icon/name=icons/spotlight/spotlight-waypoint-b.png&text=<%= text %>&psize=13&font=fonts/Roboto-Regular.ttf&color=<%= color %>&ax=41&ay=51&scale=1")
    when '50', '51' then _.template("https://chart.googleapis.com/chart?chst=d_simple_text_icon_above&chld=<%= text %>|10|000|glyphish_location|16|<%= color %>|fff")
    when '21', '22' then _.template("https://mts0.google.com/vt/icon/name=icons/spotlight/directions_decision_point_6px.png&scale=1")
    else _.template "https://chart.googleapis.com/chart?chst=d_map_spin&chld=0.3|0|<%= color %>|9|b|||<%= text %>"

  icons =
    '20':
      color : 'ff333333'
      text  : 'On'
    '21':
      color : ''
    '22':
      color : ''
    '23':
      color:  'f2c229'
    '25':
      color : 'cca069'
      text  : 'Idle'
    '30':
      color : 'ff333333'
      text  : 'Off'
    '40':
      color : 'f2f06c'
      text  : 'Accel'
    '41':
      color : 'ccca12'
      text  : 'Accel'
    '42':
      color : 'fd3f52'
      text  : 'Brake'
    '43':
      color : 'bb0214'
      text  : 'Brake'
    '44':
      color : 'bfbfbf'
      text  : 'Hard Left'
    '45':
      color : '7f7f7f'
      text  : 'Hard Left'
    '46':
      color : 'bfbfbf'
      text  : 'Hard Right'
    '47':
      color : '7f7f7f'
      text  : 'Hard Right'
    '50':
      color : '6991FD'
      text  : 'Enter'
    '51':
      color : '285aeb'
      text  : 'Exit'

  if icon = icons[eventCode]
    return iconUrl
      color : icon.color
      text  : icon.text or "#{Number(speed).toFixed()} mph"
