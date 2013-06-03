@mapIcon = (eventCode, speed) ->
  iconUrl  = _.template "https://chart.googleapis.com/chart?chst=d_map_spin&chld=0.3|0|<%= color %>|9|b|||<%= text %>"

  icons =
    '23':
      color:  'f2c229'
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

  if icon = icons[eventCode]
    return iconUrl
      color : icon.color
      text  : icon.text or "#{Number(speed).toFixed()} mph"