Zin.filter "tel", ->
  (tel) ->
    return ""  unless tel
    value = tel.toString().trim().replace(/^\+/, "")
    return tel  if value.match(/[^0-9]/)
    country = undefined
    city = undefined
    number = undefined
    switch value.length
      when 10 # +1PPP####### -> C (PPP) ###-####
        country = 1
        city = value.slice(0, 3)
        number = value.slice(3)
      when 11 # +CPPP####### -> CCC (PP) ###-####
        country = value[0]
        city = value.slice(1, 4)
        number = value.slice(4)
      when 12 # +CCCPP####### -> CCC (PP) ###-####
        country = value.slice(0, 3)
        city = value.slice(3, 5)
        number = value.slice(5)
      else
        return tel
    number = number.slice(0, 3) + "-" + number.slice(3)
    "(" + city + ") " + number