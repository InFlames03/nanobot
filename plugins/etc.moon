run = (msg,matches) ->
  if matches[1] == "lenny"
    print
    message = "( ͡° ͜ʖ ͡°)"
    return message
  elseif matches[1] == "shrug"
    print
    message = "¯\_(ツ)_/¯"
    return message
  elseif matches[1] == "classy"
    print
    message = "┌─┐\n┴─┴ \n͡° ͜ʖ ͡ರೃ"
    return message

return {
  description: "*( ͡° ͜ʖ ͡°)*"
  usage: "/lenny"
  patterns: {
  "[!/](lenny)$",
  "^[!/]lenny +(.+)$",
  "[!/](shrug)$",
  "^[!/]shrug +(.+)$",
  "[!/](classy)$",
  "^[!/]classy +(.+)$"
  }
  :run
}

