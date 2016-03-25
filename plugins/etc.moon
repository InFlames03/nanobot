message = ""
run = (msg,matches) ->
  if matches[1] == "lenny"
    print
    message = "( ͡° ͜ʖ ͡°)"
  elseif matches[1] == "shrug"
    print
    message = "¯\_(ツ)_/¯"
  elseif matches[1] == "classy"
    print
    message = "┌─┐\n┴─┴ \n͡° ͜ʖ ͡ರೃ"
  elseif matches[1] == "look"
    telegram!\sendMessage msg.chat.id, "ಠ_ಠ", false , false , true
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
  "^[!/]classy +(.+)$",
  "[!/](look)$",
  "^[!/]look +(.+)$"
  }
  :run
}
